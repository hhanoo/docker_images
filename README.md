# Docker Images

로보틱스 및 시뮬레이션등 프로젝트를 위한 Docker 이미지 모음
ROS 2, CUDA, PyTorch 등을 포함한 개발 환경 제공

## 프로젝트 이미지

| Image                                                                         | GPU | CUDA   | Ubuntu | Release |
| ----------------------------------------------------------------------------- | :-: | ------ | ------ | ------- |
| [project/apriltag-pose-ros2-humble](project/apriltag-pose-ros2-humble/)       |  -  | -      | 22.04  | v3.1.0  |
| [project/gripper-manager](project/gripper-manager/)                           |  -  | -      | -      | v1.1.0  |
| [project/hand-eye-calibration-humble](project/hand-eye-calibration-humble/)   |  O  | 12.5.1 | 22.04  | v1.4.0  |
| [project/manipulator-manager](project/manipulator-manager/)                   |  -  | -      | 22.04  | v1.0.1  |
| [project/marker-pose-benchmark-humble](project/marker-pose-benchmark-humble/) |  -  | -      | 22.04  | v1.0.1  |
| [project/poc-daekeum-humble](project/poc-daekeum-humble/)                     |  O  | 12.1.1 | 22.04  | v1.4.0  |
| [project/poc-korea-mecha](project/poc-korea-mecha/)                           |  O  | 12.1.1 | 20.04  | v1.3.1  |
| [project/poc-sfsc-conveyor-system](project/poc-sfsc-conveyor-system/)         |  O  | 12.1.1 | 22.04  | -       |

> 상세: **[hhanoo/project](project/README.md)** (Docker Hub 개요)

## ROS 2 이미지

| Image                                                               | GPU | CUDA   | Ubuntu | Release |
| ------------------------------------------------------------------- | :-: | ------ | ------ | ------- |
| [ros/humble/cuda/12.5.1/gazebo](ros/humble/cuda/12.5.1/gazebo/)     |  O  | 12.5.1 | 22.04  | -       |
| [ros/humble/cuda/12.5.1/harmonic](ros/humble/cuda/12.5.1/harmonic/) |  O  | 12.5.1 | 22.04  | -       |
| [ros/humble/desktop](ros/humble/desktop/)                           |  -  | -      | 22.04  | -       |

> 상세: **[hhanoo/ros](ros/README.md)** (Docker Hub 개요)

## 시뮬레이션 이미지

| Image                                                     | GPU | CUDA | Ubuntu | Release |
| --------------------------------------------------------- | :-: | ---- | ------ | ------- |
| [sim/isaac-sim/4.5.0-humble](sim/isaac-sim/4.5.0-humble/) |  O  | -    | 22.04  | -       |
| [sim/isaac-sim/5.1.0-jazzy](sim/isaac-sim/5.1.0-jazzy/)   |  O  | -    | 24.04  | -       |
| [sim/isaac-lab/4.5.0-humble](sim/isaac-lab/4.5.0-humble/) |  O  | -    | 22.04  | -       |
| [sim/isaac-lab/5.1.0-jazzy](sim/isaac-lab/5.1.0-jazzy/)   |  O  | -    | 24.04  | -       |

> 상세: **[hhanoo/sim](sim/README.md)** (Docker Hub 개요 및 실행 가이드)

## 요구사항

- **Docker**: 최신 버전 권장
- **NVIDIA Docker** (GPU 이미지 사용 시): CUDA 지원을 위한 nvidia-container-toolkit 필요
