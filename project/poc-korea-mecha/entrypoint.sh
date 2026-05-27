#!/bin/bash
set -e

# ===== Workspace =====
WORKSPACE="/root/workspace/POC_Korea_Mecha"

# ===== Functions =====
restore_ownership() {
    # Restore host file ownership
    if [ -n "$HOST_UID" ] && [ -n "$HOST_GID" ] && [ -d "$WORKSPACE" ]; then
        chown -R "$HOST_UID:$HOST_GID" "$WORKSPACE"
    fi
}

install_editable_packages() {
    # Install editable packages if needed
    if ! python3 -c "import ketisdk" 2>/dev/null; then
        echo "Installing ketisdk..."
        pip install -e "$WORKSPACE/modules/ketisdk"
    fi

    if ! python3 -c "import kpick" 2>/dev/null; then
        echo "Installing kpick_devel..."
        pip install -e "$WORKSPACE/modules/kpick_devel"
    fi
}

# ===== Trap =====
trap restore_ownership EXIT

# ===== Initialization =====
install_editable_packages

# ===== Default Command =====
if [ "$#" -eq 0 ]; then
    set -- /bin/bash
fi

# ===== Execute Command =====
"$@"