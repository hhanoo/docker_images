# Docker Images

로보틱스 및 컴퓨터 비전 프로젝트를 위한 Docker 이미지 모음
ROS 2, CUDA, PyTorch, OpenCV 등을 포함한 다양한 개발 환경 제공

## ROS 2 이미지

| 이미지                                                              | 설명                                   | GPU | CUDA   | Ubuntu | 릴리즈 |
| ------------------------------------------------------------------- | -------------------------------------- | :-: | ------ | ------ | ------ |
| [ros/humble/cuda/12.5.1/gazebo](ros/humble/cuda/12.5.1/gazebo/)     | GPU 가속 Gazebo 시뮬레이터 환경        |  O  | 12.5.1 | 22.04  | -      |
| [ros/humble/cuda/12.5.1/harmonic](ros/humble/cuda/12.5.1/harmonic/) | 차세대 Gazebo Harmonic 시뮬레이터 환경 |  O  | 12.5.1 | 22.04  | -      |
| [ros/humble/desktop](ros/humble/desktop/)                           | ROS 2 Humble 데스크톱 개발 환경        |  -  | -      | 22.04  | -      |

> 상세: **[hhanoo/ros](ros/DOCKERHUB.md)** (Docker Hub 개요)

## 프로젝트 이미지

| 이미지                                                                        | 설명                                         | GPU | CUDA   | Ubuntu | 릴리즈 |
| ----------------------------------------------------------------------------- | -------------------------------------------- | :-: | ------ | ------ | ------ |
| [project/apriltag-pose-ros2-humble](project/apriltag-pose-ros2-humble/)       | AprilTag 기반 포즈 추정                      |  -  | -      | 22.04  | v1.0.0 |
| [project/gripper-manager](project/gripper-manager/)                           | 그리퍼 제어 관리 애플리케이션                |  -  | -      | -      | v1.0.0 |
| [project/hand-eye-calibration-humble](project/hand-eye-calibration-humble/)   | Hand-Eye 캘리브레이션 프로그램               |  O  | 12.5.1 | 22.04  | v1.1.0 |
| [project/manipulator-manager](project/manipulator-manager/)                   | 로봇 팔/매니퓰레이터 제어 애플리케이션       |  -  | -      | 22.04  | v1.0.0 |
| [project/marker-pose-benchmark-humble](project/marker-pose-benchmark-humble/) | 마커 포즈 벤치마크                           |  -  | -      | 22.04  | v1.0.0 |
| [project/poc-korea-mecha](project/poc-korea-mecha/)                           | UR 로봇 기반 인장 시편 자동 머신 텐딩 시스템 |  O  | 12.1.1 | 20.04  | v1.1.0 |
| [project/poc-sfsc-conveyor-system](project/poc-sfsc-conveyor-system/)         | UR 로봇 기반 가죽 분류 컨베이어 시스템       |  O  | 12.1.1 | 22.04  | -      |

> 상세: **[hhanoo/project](project/DOCKERHUB.md)** (Docker Hub 개요)

## 요구사항

- **Docker**: 최신 버전 권장
- **NVIDIA Docker** (GPU 이미지 사용 시): CUDA 지원을 위한 nvidia-container-toolkit 필요
