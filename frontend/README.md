# find_toilet

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


----

## [FE] convention & file structure

## 명명

### 1. 폴더명, 파일명 : snake_case

```c
폴더명과 내부 파일의 역할이 정확한 분류라면 파일의 이름에 폴더명을 추가
(적지 않아도 명확히 특정 폴더 소속임이 명확하다면 파일 이름에 폴더명 생략)
ex) 폴더명: screens, 파일명: login_screen.dart

폴더명은 복수형으로, 파일명은 단수형으로 작성
ex) 폴더명: screens, 파일명: login_screen.dart
```

### 2. 변수명, 함수명 : camelCase

### 3. 클래스명 : PascalCase

```c
클래스를 하나의 파일로 정리한다면 파일명과 클래스명은 동일하게 작성
ex) 파일명: login_screen.dart , 클래스명: LoginScreen
```

## 파일 구조

### 1. assets

```c
프로젝트 수준에 위치
앱에서 사용할 asset(로고, 아이콘, 앱 전체에서 사용되는 정적 이미지 등)들을 모아두는 폴더
안에 fonts, images, logo 등의 세부 폴더가 존재
```

⇒ assets 폴더에 저장되면, pubspec.yaml에 등록해야 함

### 2. lib/screens

```c
화면의 UI들을 보관하는 폴더 (화면 전반 담당)
특정 기능마다 화면 분류가 필요해 질 경우, 세부 폴더가 존재할 수 있음
```

⇒ 간단한 화면인 경우 해당 폴더 안에 하나의 파일, 좀 더 복잡한 화면이라면 더 큰 위젯에 사용할 local_widgets 폴더 포함시켜 코드를 깔끔하게 유지할 수 있음

### 3. lib/widgets

```c
UI를 담당하는 위젯들을 모아두는 폴더
화면의 부분부분의 요소들 중 재사용되는 UI들을 모아둔 곳
```

### 4. lib/utilities

```c
앱에서 사용하는 function, logic을 모아두는 폴더
```

### 5. lib/providers

```c
앱 외부의 다른 서비스들과 앱을 연결할때 사용하는 내용들을 정리
플러터 패키지 중의 하나인 provider와 다름
```

⇒ flutter에서는 dio 라이브러리를 통신 패키지로 많이 사용

### 6. lib/models

```
데이터베이스와 데이터를 주고받기 위해 사용하는 파일들을 모아두는 폴더
(모델 : 서버, 사용자 또는 외부 API에서 제공되는 데이터의 모음)

앱 전체에서 사용되는 데이터들을 저장하는 데 사용
global 구조
```

