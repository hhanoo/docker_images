# hhanoo/sim

NVIDIA Isaac Sim / Isaac Lab 기반 시뮬레이션 환경 Docker 이미지

**GitHub**: [docker_images/sim](https://github.com/hhanoo/docker_images/tree/main/sim)

## 태그 목록

| 태그                     | 설명                                              | GPU | Ubuntu | ROS 2  | Isaac Sim |
| ------------------------ | ------------------------------------------------- | :-: | ------ | ------ | --------- |
| `isaac-sim-4.5.0-humble` | Isaac Sim 4.5.0 + ROS 2 Humble + CycloneDDS       |  O  | 22.04  | Humble | 4.5.0     |
| `isaac-sim-5.1.0-jazzy`  | Isaac Sim 5.1.0 + ROS 2 Jazzy + CycloneDDS        |  O  | 24.04  | Jazzy  | 5.1.0     |
| `isaac-lab-4.5.0-humble` | 위 4.5.0-humble 베이스 + Isaac Lab v2.2.1 + RL FW |  O  | 22.04  | Humble | 4.5.0     |
| `isaac-lab-5.1.0-jazzy`  | 위 5.1.0-jazzy 베이스 + Isaac Lab v2.3.2 + RL FW  |  O  | 24.04  | Jazzy  | 5.1.0     |

## Pull

```bash
docker pull hhanoo/sim:isaac-sim-4.5.0-humble
docker pull hhanoo/sim:isaac-sim-5.1.0-jazzy
docker pull hhanoo/sim:isaac-lab-4.5.0-humble
docker pull hhanoo/sim:isaac-lab-5.1.0-jazzy
```

---

## 이미지 상세

### isaac-sim-4.5.0-humble

- **베이스**: `nvcr.io/nvidia/isaac-sim:4.5.0`
- **OS**: Ubuntu 22.04
- **ROS**: ROS 2 Humble (`ros-base` + 핵심 패키지)
- **RMW**: `rmw_cyclonedds_cpp` (대형 센서 메시지 안정성)
- **주요 기능**: Isaac Sim GUI/Headless, ROS 2 bridge 자동 활성화, OmniGraph

### isaac-sim-5.1.0-jazzy

- **베이스**: `nvcr.io/nvidia/isaac-sim:5.1.0`
- **OS**: Ubuntu 24.04
- **ROS**: ROS 2 Jazzy (`ros-base` + 핵심 패키지)
- **RMW**: `rmw_cyclonedds_cpp`
- **주의**: Humble 컨테이너와 직접 ROS 2 통신 불가 (distro 다름)

### isaac-lab-4.5.0-humble

- **베이스**: `hhanoo/sim:isaac-sim-4.5.0-humble`
- **Isaac Lab**: v2.2.1 (Isaac Sim 4.5.0 호환 안정 릴리스)
- **RL 프레임워크**: `rsl_rl`, `rl_games`, `sb3`, `skrl`
- **설치 위치**: `/IsaacLab`
- **용도**: 강화학습 / 모방학습 / 로봇 제어 학습

### isaac-lab-5.1.0-jazzy

- **베이스**: `hhanoo/sim:isaac-sim-5.1.0-jazzy`
- **Isaac Lab**: v2.3.2 (Isaac Sim 5.1.0 호환 안정 릴리스)
- **RL 프레임워크**: `rsl_rl`, `rl_games`, `sb3`, `skrl`
- **설치 위치**: `/IsaacLab`
- **주의**: Humble 컨테이너와 직접 ROS 2 통신 불가 (distro 다름)

---

## 실행

세 이미지 모두 같은 docker run 패턴(GPU + X11 + 캐시 볼륨)이라 `run.sh` 하나로 처리.
첫 실행 시 `config.sh`가 `config.sh.example`에서 자동 복사됨 (개인 설정용, gitignored).

### 기본 사용

```bash
cd sim/

# 기본 — config.sh의 IMAGE_NAME 사용 (기본값: isaac-sim-4.5.0-humble)
./run.sh

# CLI 인자로 태그 오버라이드
./run.sh isaac-sim-4.5.0-humble
./run.sh isaac-sim-5.1.0-jazzy
./run.sh isaac-lab-4.5.0-humble
```

### 설정 변경

`config.sh` 직접 수정 (자동 생성된 개인 설정 파일):

```bash
# config.sh
IMAGE_NAME="hhanoo/sim:isaac-lab-4.5.0-humble"
CONTAINER_NAME="my-isaac-lab"
ROS_DOMAIN_ID="42"
CACHE_ROOT="$HOME/docker/isaac-sim"
```

### run.sh 동작 단계

1. **호스트 커널 튜닝** — DDS 대형 메시지(rmem/wmem, ipfrag)를 위한 sysctl 적용 (sudo 필요)
2. **X11 권한 부여** — `xhost +local:docker`
3. **컨테이너 실행** — 캐시 디렉토리 자동 생성 + docker run
4. **종료 후 정리** — `xhost -local:docker`

### 컨테이너 두 번째 터미널 진입

다른 호스트 터미널에서:

```bash
docker exec -it isaac-sim-4.5.0-humble bash
```

---

## 컨테이너 내부 헬퍼 명령

진입 시 `commands.sh`가 자동 로드되어 다음 명령 사용 가능:

| 명령                | 설명                                           |
| ------------------- | ---------------------------------------------- |
| `isaacsim`          | GUI 실행 (ROS 2 bridge 자동 활성화)            |
| `isaacsim_headless` | 헤드리스 실행                                  |
| `isaaclab`          | `/IsaacLab/isaaclab.sh` 래퍼 (Lab 이미지 한정) |
| `build`             | `colcon build` (`/ros2_ws`)                    |
| `cmd_help`          | 명령 목록 출력                                 |

### Isaac Lab 사용 예

```bash
# 빈 시뮬레이션 (Lab 동작 검증)
isaaclab -p scripts/tutorials/00_sim/create_empty.py

# Cartpole RL 학습 (헤드리스)
isaaclab -p scripts/reinforcement_learning/rsl_rl/train.py \
    --task Isaac-Cartpole-v0 --headless

# 학습된 정책 시각화
isaaclab -p scripts/reinforcement_learning/rsl_rl/play.py \
    --task Isaac-Cartpole-v0 --num_envs 32
```

---

## 캐시 전략

캐시는 Isaac Sim **버전별로 분리** (run.sh가 자동 처리). 같은 폴더 공유 시 셰이더/Python wheel 충돌로 segfault 가능.

| 캐시             | 4.5 ↔ 5.1 호환                     |
| ---------------- | ---------------------------------- |
| Kit 셰이더 캐시  | ❌ Kit 버전 다름 (106.x vs 107.x)  |
| pip wheel 캐시   | ❌ Python 버전 다름 (3.10 vs 3.12) |
| OpenGL/CUDA 캐시 | ⚠️ 셰이더 바이너리, 충돌 가능      |
| USD 에셋 캐시    | ⚠️ 일부 공유 가능하나 권장 안 함   |

→ run.sh가 `~/docker/isaac-sim/<version>/`로 분리 마운트.

Isaac Lab 이미지는 베이스 4.5.0과 Kit·Python 버전이 같아 **`4.5.0/` 캐시 공유 안전**.

---

## ROS 2 통신

### 같은 distro끼리만 통신 가능

```
[isaac-sim-4.5.0-humble] ⇄ [Humble + CycloneDDS 컨테이너]   ✅
[isaac-sim-5.1.0-jazzy ] ⇄ [Jazzy  + CycloneDDS 컨테이너]   ✅
[isaac-sim-4.5.0-humble] ⇄ [isaac-sim-5.1.0-jazzy]        ❌ distro 다름
```

### 양쪽 컨테이너에 통일 필요

- `--network host`
- `ROS_DOMAIN_ID` 동일 (예: 98)
- `RMW_IMPLEMENTATION=rmw_cyclonedds_cpp` (entrypoint에서 자동 설정)

### 호스트 ROS 2 불필요

컨테이너 ↔ 컨테이너 통신은 호스트 ROS 2 distro와 무관. 호스트는 단순 네트워크 패스스루 역할.

---

## 요구사항

- **Docker**: 최신 버전 권장
- **NVIDIA Container Toolkit**: GPU 사용 필수 (`nvidia-container-toolkit`)
- **NVIDIA Driver**: 535+ (RTX 4090 권장 560+)
- **NGC 로그인**: `nvcr.io` 이미지 pull용 (`docker login nvcr.io`)
- **디스크**: 베이스 이미지당 ~15GB

## 참고

- [Isaac Sim Docker 가이드](https://docs.isaacsim.omniverse.nvidia.com/latest/installation/install_container.html)
- [Isaac Sim ROS 2 설치](https://docs.isaacsim.omniverse.nvidia.com/latest/installation/install_ros.html)
- [Isaac Lab GitHub](https://github.com/isaac-sim/IsaacLab)
- [NGC Isaac Sim 카탈로그](https://catalog.ngc.nvidia.com/orgs/nvidia/containers/isaac-sim)
