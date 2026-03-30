# hhanoo/project

프로젝트별 특화 Docker 이미지

## 태그 목록

| 태그                           | 설명                                         | GPU | CUDA   | Ubuntu | 릴리즈 |
| ------------------------------ | -------------------------------------------- | :-: | ------ | ------ | ------ |
| `apriltag-pose-ros2-humble`    | AprilTag 기반 포즈 추정                      |  -  | -      | 22.04  | v1.0.0 |
| `gripper-manager`              | 그리퍼 제어 관리 애플리케이션                |  -  | -      | -      | v1.0.0 |
| `hand-eye-calibration-humble`  | Hand-Eye 캘리브레이션 프로그램               |  O  | 12.5.1 | 22.04  | v1.1.0 |
| `manipulator-manager`          | 로봇 팔/매니퓰레이터 제어 애플리케이션       |  -  | -      | 22.04  | v1.0.0 |
| `marker-pose-benchmark-humble` | 마커 포즈 벤치마크                           |  -  | -      | 22.04  | v1.0.0 |
| `poc-korea-mecha`              | UR 로봇 기반 인장 시편 자동 머신 텐딩 시스템 |  O  | 12.1.1 | 20.04  | v1.1.0 |
| `poc-sfsc-conveyor-system`     | UR 로봇 기반 가죽 분류 컨베이어 시스템       |  O  | 12.1.1 | 22.04  | -      |

## 사용법

```bash
# AprilTag 포즈 추정
docker pull hhanoo/project:apriltag-pose-ros2-humble

# 그리퍼 제어
docker pull hhanoo/project:gripper-manager

# Hand-Eye 캘리브레이션
docker pull hhanoo/project:hand-eye-calibration-humble

# 매니퓰레이터 제어
docker pull hhanoo/project:manipulator-manager

# 마커 포즈 벤치마크
docker pull hhanoo/project:marker-pose-benchmark-humble

# 기계/로보틱스 POC
docker pull hhanoo/project:poc-korea-mecha

# 컨베이어 시스템 POC
docker pull hhanoo/project:poc-sfsc-conveyor-system
```

## 이미지 상세

### apriltag-pose-ros2-humble

- **베이스**: `hhanoo/ros:humble-desktop`
- **주요 기능**: AprilTag 포즈 추정, Modbus 통신, RealSense, ROS 2 Humble
- **GitHub**: https://github.com/hhanoo/AprilTag_Pose_ROS2

### gripper-manager

- **베이스**: `python:3.10-slim`
- **주요 기능**: PySide6 GUI, Modbus 통신, USB 지원
- **GitHub**: https://github.com/hhanoo/Gripper_manager

### hand-eye-calibration-humble

- **베이스**: `nvidia/cuda:12.5.1-devel-ubuntu22.04`
- **주요 기능**: CUDA 12.5.1, ROS 2 Humble, Hand-Eye 캘리브레이션, RealSense, OpenCV, PyQt5, ros2-control
- **GitHub**: https://github.com/hhanoo/hand-eye_calibration

### manipulator-manager

- **베이스**: `stateoftheartio/qt6:6.7-gcc-aqt`
- **주요 기능**: Qt 6.7, CMake, OpenGL, Vulkan, Eigen3, libcurl
- **GitHub**: https://github.com/hhanoo/Manipulator_manager

### marker-pose-benchmark-humble

- **베이스**: `hhanoo/ros:humble-desktop`
- **주요 기능**: AprilTag 포즈 벤치마크, UR 로봇 드라이버, RealSense, OpenCV, PyQt5, ROS 2 control
- **GitHub**: https://github.com/hhanoo/marker_pose_benchmark

### poc-korea-mecha

- **베이스**: `nvidia/cuda:12.1.1-devel-ubuntu20.04`
- **주요 기능**: CUDA 12.1.1, PyTorch 2.4.1, OpenCV, RealSense, Modbus, PyQt5
- **GitHub**: https://github.com/hhanoo/POC_Korea_Mecha

### poc-sfsc-conveyor-system

- **베이스**: `nvidia/cuda:12.1.1-devel-ubuntu22.04`
- **주요 기능**: CUDA 12.1.1, PyTorch 2.4.1, PyQt5, RealSense, BiRefNet
- **GitHub**: https://github.com/hhanoo/POC_SFSC/tree/sw_cert_2

## 요구사항

- **Docker**: 최신 버전 권장
- **NVIDIA Docker** (GPU 이미지 사용 시): nvidia-container-toolkit 필요
