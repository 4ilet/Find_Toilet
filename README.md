# 🔎 화장실을 찾아서 (Find Toilet) 

![https://user-images.githubusercontent.com/97578425/218648379-bfe508d9-21f5-4271-b230-7a97d52954ea.png](https://user-images.githubusercontent.com/97578425/218648379-bfe508d9-21f5-4271-b230-7a97d52954ea.png)

## 목차
[1. 소개](#1️⃣-소개)

[2. 일정](#2️⃣-일정)

[3. 시스템 아키텍처](#3️⃣-시스템-아키텍처)

[4. 기능](#4️⃣-기능)

[5. 개발 환경](#5️⃣-개발-환경)

[6. 참고 자료](#6️⃣-참고-자료)

[7. 개발팀 소개](#7️⃣-개발팀-소개)

---

## 1️⃣ 소개
- 낯선 곳에서, 혹은 급한 상황에서 화장실을 찾지 못해 당황스러웠던 적이 있진 않으신가요?
- **화장실을 찾아서**는 그런 상황에서 유용하게 활용할 수 있도록 **공공화장실 정보**를 제공하는 애플리케이션입니다.
- 24시간 운영 유무, 장애인용 화장실 유무 등 **필터링 기능**을 제공하여 현재 필요한 화장실을 정확하게 찾을 수 있습니다.
- 자주 이용하는 곳은 **리뷰**를 남기고, **즐겨찾기**해보세요!

### 🔗 [앱 다운 받기]()

<br>

## 2️⃣ 일정

> 총 개발 기간 : 2023.01.25 ~ 2023.04.nn (약 n주 소요)<br />
- 2023.01.25 ~ 2023.02.12 : 기획 및 UI 디자인 (약 2주 소요)
- 2023.02.13 ~ 2023.04.nn : FE/BE 개발 (약 3주 소요)
- 2023.04.nn ~ 2023.04.nn : QA 및 마켓 등록

## 3️⃣ 시스템 아키텍처
![시스템 아키텍처](./assets/system_architecture.jpeg)

<br>

## 4️⃣ 기능
### 내 주변 화장실 찾기
- 나의 GPS를 기반으로 주변 화장실을 찾아볼 수 있습니다.
- 필터링 기능을 제공합니다. ( 24시간 / 장애인용 / 어린이용 / 기저귀 교환대 )

### 검색
- 검색을 통해 화장실을 찾아볼 수 있습니다.
- 필터링 기능을 제공합니다. ( 24시간 / 장애인용 / 어린이용 / 기저귀 교환대 )
- 검색 결과의 정렬 기준을 선택할 수 있습니다. ( 거리순 / 평점순 / 리뷰순 )

### 즐겨찾기
- 자주 가는 곳을 즐겨찾기할 수 있습니다.
- 폴더를 만들어 즐겨찾기를 관리할 수 있습니다.

### 설정
- 큰 글씨 모드와 반경 설정 기능을 제공합니다.
- 문의하기를 통해 개발팀 포일렛에 관련 문의를 남길 수 있습니다.

<br>

## 5️⃣ 개발 환경
| Part | Tech |
| :--: | :--: |
| **Front-End** | <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white"> <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white"> <img src="https://img.shields.io/badge/Dart-02569B?style=for-the-badge&logo=flutter&logoColor=white">|
| **Back-End** | <img src="https://img.shields.io/badge/spring_boot-6DB33F?style=for-the-badge&logo=springboot&logoColor=white"> <img src="https://img.shields.io/badge/spring_Data_JPA-6DB33F?style=for-the-badge&logo=spring&logoColor=white"> <img src="https://img.shields.io/badge/spring_Security-6DB33F?style=for-the-badge&logo=springsecurity&logoColor=white"> <img src="https://img.shields.io/badge/JWT-000000?style=for-the-badge&logo=jsonwebtokens&logoColor=white"> <img src="https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white">|
| **Deployment** | <img src="https://img.shields.io/badge/amazon_ec2-FF9900?style=for-the-badge&logo=amazonec2&logoColor=white"> <img src="https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white"> <img src="https://img.shields.io/badge/Jenkins-D24939?style=for-the-badge&logo=jenkins&logoColor=white">|
|**Communication**|<img src="https://img.shields.io/badge/Notion-000000?style=for-the-badge&logo=notion&logoColor=white"> <img src="https://img.shields.io/badge/Figma-F24E1E?style=for-the-badge&logo=figma&logoColor=white"> <img src="https://img.shields.io/badge/Slack-4A154B?style=for-the-badge&logo=Slack&logoColor=white"> <img src="https://img.shields.io/badge/Discord-5865F2?style=for-the-badge&logo=Discord&logoColor=white"> |

<br>

## 6️⃣ 참고 자료
### 1️⃣ ERD 다이어그램
![](./assets/erd.jpeg)
### 2️⃣ 와이어프레임
![](./assets/figma.png)
### 3️⃣ Swagger 🔗 [Link](http://43.201.124.70:8080/swagger-ui/)

<br>

## 7️⃣ 개발팀 소개
|<img src="https://avatars.githubusercontent.com/u/97578425?v=4" width="100" height="100"/>|<img src="https://avatars.githubusercontent.com/u/61959111?v=4" width="100" height="100"/>|<img src="https://avatars.githubusercontent.com/u/97578485?v=4" width="100" height="100"/>|<img src="https://avatars.githubusercontent.com/u/97578460?v=4" width="100" height="100"/>|
|:---:|:---:|:---:|:---:|
|**Backend**|**Backend**|**Frontend**|**Frontend**|
|[김윤주](https://github.com/gimewn)|[나장엽](https://github.com/kaydenna92)|[나원경](https://github.com/hitriee)|[박한](https://github.com/Hanpark04)|

