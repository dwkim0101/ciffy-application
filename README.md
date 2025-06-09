# CIFFY Application

<p align="center">
  <img src="assets/Logo.svg" alt="CIFFY Logo" width="220"/>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Award-Grand%20Prize%20(Computer%20Science)-gold" alt="컴퓨터공학과 학장상"/>
  <img src="https://img.shields.io/badge/Award-Grand%20Prize%20(President's%20Award)-blue" alt="총장상"/>
  <img src="https://img.shields.io/badge/Platform-iOS%20%7C%20Android-green" alt="플랫폼"/>
</p>

## 🏆 수상 내역

- **컴퓨터공학과 학술제 대상 (컴퓨터공학과 학장상)**
- **세종대학교 소프트웨어융합학술제 대상 (세종대학교 총장상)**

## 📝 프로젝트 소개

CIFFY는 세종대학교 학생들을 위한 혁신적인 시간표 제작 및 관리 애플리케이션입니다. 사용자 중심의 직관적인 인터페이스와 세종대학교 포털 연동 기능으로 학생들의 학기 계획을 효율적으로 지원합니다.

복잡한 강의 선택과 시간표 작성 과정을 간소화하여 학생들이 더 나은 학업 계획을 세울 수 있도록 도와줍니다. 그 우수성을 인정받아 컴퓨터공학과 학술제와 세종대학교 소프트웨어융합학술제에서 모두 대상을 수상하였습니다.

## ✨ 주요 기능

- **마이페이지**: 사용자 정보, 프로필, 수강 과목, 로그아웃/계정 삭제 등 직관적 UI 제공
- **시간표 제작 및 관리**: 쉽고 빠른 시간표 작성, 강의 시간 충돌 감지, 다양한 템플릿
- **세종대학교 포털 연동**: 포털 계정 로그인, 강의 정보 자동 동기화, 강의계획서 조회

## 📱 스크린샷

<p align="center">
  <img src="screenshots/start_screen.png" alt="시작 화면" width="200"/>
  <img src="screenshots/login_screen.png" alt="로그인 화면" width="200"/>
  <img src="assets/mypage_example.png" alt="마이페이지 예시" width="200"/>
</p>

> **마이페이지**: block_character.svg를 활용한 프로필, Pretendard 폰트, 세련된 카드 UI, 하단 네비게이션 등 최신 디자인 적용

## 🛠️ 기술 스택 및 주요 라이브러리

- **Frontend**: Flutter, Dart
- **UI/UX**: Material Design, Custom UI Components, Pretendard/SUIT 폰트
- **SVG 지원**: [flutter_svg](https://pub.dev/packages/flutter_svg)로 SVG 아이콘 및 일러스트 활용
- **Authentication**: Secure Login System

## 📦 주요 Asset 및 폰트 안내

- **SVG 일러스트/아이콘**: `assets/block_character.svg`, `assets/bottom_bar/*.svg` 등 다양한 SVG 활용
- **커스텀 폰트**: Pretendard, SUIT (모든 굵기 지원)
- **폰트/asset 등록**: `pubspec.yaml`에 이미 등록되어 있음

## 🚀 시작하기

### 요구사항

- Flutter 3.0.0 이상
- Dart 2.17.0 이상

### 설치 방법

1. 저장소 클론

```bash
git clone https://github.com/dwkim0101/ciffy-application.git
```

2. 종속성 설치

```bash
flutter pub get
```

3. 앱 실행

```bash
flutter run
```

> **참고:** Pretendard/SUIT 폰트와 SVG asset은 모두 저장소에 포함되어 있습니다. 별도 추가 작업 없이 바로 실행 가능합니다.

## 👨‍💻 개발팀

CIFFY는 세종대학교 컴퓨터공학과 학생들로 구성된 팀에 의해 개발되었습니다.

## 🤝 기여하기

프로젝트에 기여하고 싶으시다면 이슈를 제기하거나 풀 리퀘스트를 보내주세요. 모든 기여는 소중히 검토됩니다.

## 📄 라이선스

이 프로젝트는 MIT 라이선스 하에 배포됩니다.

---

<p align="center">
  <b>CIFFY - 세종대학교 학생들을 위한 최고의 시간표 솔루션</b><br>
  컴퓨터공학과 학술제 대상 & 세종대학교 소프트웨어융합학술제 총장상 수상작
</p>
