# hhanoo/ros

ROS 2 기반 로보틱스 개발을 위한 Docker 이미지

## 태그 목록

| 태그 | 설명 | GPU | CUDA | Ubuntu |
|------|------|:---:|------|--------|
| `humble-desktop` | ROS 2 Humble 데스크톱 개발 환경 | - | - | 22.04 |
| `humble-cuda-12.5.1-gazebo` | GPU 가속 Gazebo 시뮬레이터 환경 | O | 12.5.1 | 22.04 |
| `humble-cuda-12.5.1-harmonic` | 차세대 Gazebo Harmonic 시뮬레이터 환경 | O | 12.5.1 | 22.04 |

## 사용법

```bash
# ROS 2 Humble 데스크톱
docker pull hhanoo/ros:humble-desktop

# GPU 가속 Gazebo
docker pull hhanoo/ros:humble-cuda-12.5.1-gazebo

# GPU 가속 Gazebo Harmonic
docker pull hhanoo/ros:humble-cuda-12.5.1-harmonic
```

## 이미지 상세

### humble-desktop

- **베이스**: `ros:humble-ros-base-jammy`
- **주요 기능**: RViz, rqt, OpenCV, colcon 빌드 도구 포함

### humble-cuda-12.5.1-gazebo

- **베이스**: `nvidia/cuda:12.5.1-devel-ubuntu22.04`
- **주요 기능**: CUDA 12.5.1, Gazebo, ROS 2 control, 컴퓨터 비전 패키지

### humble-cuda-12.5.1-harmonic

- **베이스**: `nvidia/cuda:12.5.1-devel-ubuntu22.04`
- **주요 기능**: CUDA 12.5.1, Gazebo Harmonic, ros-gz 브리지, 고급 로보틱스 패키지

## 요구사항

- **Docker**: 최신 버전 권장
- **NVIDIA Docker** (GPU 이미지 사용 시): nvidia-container-toolkit 필요
