#!/bin/bash

# Directories & Variables
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Load common variables (auto-copy from example if not exists)
if [ ! -f "$SCRIPT_DIR/config.sh" ]; then
    cp "$SCRIPT_DIR/config.sh.example" "$SCRIPT_DIR/config.sh"
fi
source "$SCRIPT_DIR/config.sh"

# CLI argument overrides config.sh image
# - Usage: ./run.sh isaac-sim-5.1.0-jazzy
if [ -n "$1" ]; then
    IMAGE_NAME="hhanoo/sim:$1"
    CONTAINER_NAME="$1"
fi

# Resolve Isaac Sim version (cache key) from image tag
case "$IMAGE_NAME" in
    *isaac-sim-4.5.0-humble*|*isaac-lab-4.5.0-humble*)
        SIM_VERSION="4.5.0"
        ;;
    *isaac-sim-5.1.0-jazzy*|*isaac-lab-5.1.0-jazzy*)
        SIM_VERSION="5.1.0"
        ;;
    *)
        echo "Error: unknown image '$IMAGE_NAME'"
        echo "Available tags:"
        echo "  isaac-sim-4.5.0-humble"
        echo "  isaac-sim-5.1.0-jazzy"
        echo "  isaac-lab-4.5.0-humble"
        echo "  isaac-lab-5.1.0-jazzy"
        exit 1
        ;;
esac

# Cache directories (auto-created if not exists)
CACHE_DIR="$CACHE_ROOT/$SIM_VERSION"

# Optional ROS2 workspace mount (URDF / USD / custom scripts on host)
# - Set ROS2_WS_ROOT in config.sh, or override per-run:
#     ROS2_WS_ROOT=/path/to/project ./run.sh
# - Empty = no workspace mount.
WORKSPACE_OPTS=""
if [ -n "$ROS2_WS_ROOT" ]; then
    ROS2_WS_ROOT="$(realpath "$ROS2_WS_ROOT")"
    if [ ! -d "$ROS2_WS_ROOT" ]; then
        echo "Error: ROS2_WS_ROOT '$ROS2_WS_ROOT' does not exist."
        exit 1
    fi
    WORKSPACE_OPTS="-v $ROS2_WS_ROOT:/ros2_ws:rw"
fi

# Check if the image exists
if ! docker image inspect "$IMAGE_NAME" > /dev/null 2>&1; then
    echo "Error: Image $IMAGE_NAME not found."
    echo "Pull the image first: docker pull $IMAGE_NAME"
    echo "Or build locally: cd <tag-folder> && docker build -t $IMAGE_NAME ."
    exit 1
fi

# [1/3] Host kernel tuning for ROS2 / CycloneDDS large sensor messages
echo "==> [1/3] Tuning host kernel (rmem/wmem, ipfrag) for ROS2 DDS..."
sudo sysctl -qw net.core.rmem_max=67108864
sudo sysctl -qw net.core.rmem_default=67108864
sudo sysctl -qw net.core.wmem_max=67108864
sudo sysctl -qw net.core.wmem_default=67108864
sudo sysctl -qw net.ipv4.ipfrag_time=3
sudo sysctl -qw net.ipv4.ipfrag_high_thresh=134217728

# [2/3] Enable X11 access for Docker
echo "==> [2/3] Enabling X11 access for Docker (xhost +local:docker)..."
xhost +local:docker > /dev/null 2>&1

# Create cache subdirectories
mkdir -p \
    "$CACHE_DIR/cache/kit" \
    "$CACHE_DIR/cache/ov" \
    "$CACHE_DIR/cache/pip" \
    "$CACHE_DIR/cache/glcache" \
    "$CACHE_DIR/cache/computecache" \
    "$CACHE_DIR/logs" \
    "$CACHE_DIR/data" \
    "$CACHE_DIR/documents"

# [3/3] Run the Docker container
echo "==> [3/3] Starting container '$CONTAINER_NAME' from image '$IMAGE_NAME'..."
echo "         Cache:     $CACHE_DIR"
if [ -n "$ROS2_WS_ROOT" ]; then
    echo "         Workspace: $ROS2_WS_ROOT -> /ros2_ws"
fi
echo "---------- container output ----------"
echo
docker run -it --rm \
    --name "$CONTAINER_NAME" \
    --gpus all \
    --network host \
    --ipc=host \
    \
    -e DISPLAY="$DISPLAY" \
    -e QT_X11_NO_MITSHM=1 \
    -e ROS_DOMAIN_ID="$ROS_DOMAIN_ID" \
    \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v /etc/localtime:/etc/localtime:ro \
    -v "$CACHE_DIR/cache/kit":/isaac-sim/kit/cache:rw \
    -v "$CACHE_DIR/cache/ov":/root/.cache/ov:rw \
    -v "$CACHE_DIR/cache/pip":/root/.cache/pip:rw \
    -v "$CACHE_DIR/cache/glcache":/root/.cache/nvidia/GLCache:rw \
    -v "$CACHE_DIR/cache/computecache":/root/.nv/ComputeCache:rw \
    -v "$CACHE_DIR/logs":/root/.nvidia-omniverse/logs:rw \
    -v "$CACHE_DIR/data":/root/.local/share/ov/data:rw \
    -v "$CACHE_DIR/documents":/root/Documents:rw \
    $WORKSPACE_OPTS \
    \
    "$IMAGE_NAME"

# Cleanup after container exit
echo
echo "---------- cleanup ----------"

# Restore workspace ownership (cache stays root-owned — read-only from host side)
if [ -n "$ROS2_WS_ROOT" ]; then
    echo "==> [1/2] Restoring workspace ownership to $(id -un):$(id -gn)"
    sudo chown -R "$(id -u):$(id -g)" "$ROS2_WS_ROOT"
else
    echo "==> [1/2] Skipping workspace chown (ROS2_WS_ROOT not set)"
fi

# Disable X11 access after container exit
echo "==> [2/2] Disabling X11 access after container exit..."
xhost -local:docker > /dev/null 2>&1
