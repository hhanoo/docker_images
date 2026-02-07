# Docker Images

로보틱스 및 컴퓨터 비전 프로젝트를 위한 Docker 이미지 모음
ROS 2, CUDA, PyTorch, OpenCV 등을 포함한 다양한 개발 환경 제공

## 디렉토리 구조

```
docker_images/
├── ros/                      # ROS 2 기반 이미지
│   └── humble/
│       ├── desktop/          # ROS 2 Humble 데스크톱 환경
│       └── cuda/
│           └── 12.5.1/
│               ├── gazebo/   # GPU 가속 Gazebo 시뮬레이터
│               └── harmonic/ # GPU 가속 Gazebo Harmonic
└── project/                  # 프로젝트별 특화 이미지
    ├── daekeum-poc/
    ├── gripper-manager/
    ├── korea-mecha-poc/
    ├── manipulator-manager/
    ├── marker-standard/
    └── sfsc-conveyor-system-poc/
```

## Docker 이미지 목록

### ROS 2 이미지

#### ros/humble/desktop

- **목적**: ROS 2 Humble 데스크톱 개발 환경
- **주요 기능**: RViz, rqt, OpenCV, colcon 빌드 도구 포함
- **베이스**: `ros:humble-ros-base-jammy`

#### ros/humble/cuda/12.5.1/gazebo

- **목적**: GPU 가속 Gazebo 시뮬레이터 환경
- **주요 기능**: CUDA 12.5.1, Gazebo, ROS 2 control, 컴퓨터 비전 패키지
- **베이스**: `nvidia/cuda:12.5.1-devel-ubuntu22.04`

#### ros/humble/cuda/12.5.1/harmonic

- **목적**: 차세대 Gazebo Harmonic 시뮬레이터 환경
- **주요 기능**: CUDA 12.5.1, Gazebo Harmonic, ros-gz 브리지, 고급 로보틱스 패키지
- **베이스**: `nvidia/cuda:12.5.1-devel-ubuntu22.04`

### 프로젝트 이미지

#### project/daekeum-poc

- **목적**: 컴퓨터 비전 및 로보틱스 POC 환경
- **주요 기능**: CUDA 12.5.1, PyTorch 2.5.1, OpenCV, RealSense, CLIP, QT5, Modbus
- **베이스**: `nvidia/cuda:12.5.1-devel-ubuntu22.04`

#### project/gripper-manager

- **목적**: 그리퍼 제어 관리 애플리케이션
- **주요 기능**: PySide6 GUI, Modbus 통신, USB 지원
- **베이스**: `python:3.10-slim`

#### project/korea-mecha-poc

- **목적**: 기계/로보틱스 POC 환경
- **주요 기능**: CUDA 12.1.1, PyTorch 2.4.1, OpenCV, RealSense, Modbus
- **베이스**: `nvidia/cuda:12.1.1-devel-ubuntu20.04`

#### project/manipulator-manager

- **목적**: 로봇 팔/매니퓰레이터 제어 애플리케이션
- **주요 기능**: Qt 6.7, CMake, OpenGL, Vulkan, Eigen3, libcurl
- **베이스**: `stateoftheartio/qt6:6.7-gcc-aqt`

#### project/marker-standard

- **목적**: 마커 감지 및 추적 애플리케이션
- **주요 기능**: AprilTag 감지, OpenCV, RealSense, OpenGL, headless 렌더링
- **베이스**: `ubuntu:22.04`

#### project/sfsc-conveyor-system-poc

- **목적**: 컨베이어 시스템 및 로보틱스 제어 POC
- **주요 기능**: CUDA 12.1.1, PyTorch 2.4.1, PyQt5, RealSense, BiRefNet, 포트 8090 노출
- **베이스**: `nvidia/cuda:12.1.1-devel-ubuntu22.04`

## 기술 스택

### 로보틱스

- **ROS 2 Humble**: 로봇 운영 체제
- **Gazebo / Gazebo Harmonic**: 로봇 시뮬레이터
- **ros2_control**: 로봇 제어 프레임워크

### GPU / 머신러닝

- **CUDA**: 12.1.1, 12.5.1
- **PyTorch**: 2.4.1, 2.5.1
- **torchvision**: GPU 가속 컴퓨터 비전

### 컴퓨터 비전

- **OpenCV**: 이미지 처리 및 컴퓨터 비전
- **Intel RealSense SDK**: 깊이 카메라 지원
- **AprilTag (dt-apriltags)**: 마커 감지
- **CLIP (OpenAI)**: 비전-언어 모델

### GUI 프레임워크

- **Qt 5 / Qt 6**: C++ GUI 프레임워크
- **PySide6 / PyQt5**: Python Qt 바인딩

### 산업 통신

- **Modbus (pymodbus)**: 산업용 통신 프로토콜

### 기타

- **CMake, Ninja, colcon**: 빌드 시스템
- **Eigen3**: 선형 대수 라이브러리
- **mesa, OpenGL, Vulkan**: 그래픽스 라이브러리

## 요구사항

- **Docker**: 최신 버전 권장
- **NVIDIA Docker** (GPU 이미지 사용 시): CUDA 지원을 위한 nvidia-container-toolkit 필요
