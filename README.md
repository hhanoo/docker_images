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

## 요구사항

- **Docker**: 최신 버전 권장
- **NVIDIA Docker** (GPU 이미지 사용 시): CUDA 지원을 위한 nvidia-container-toolkit 필요
