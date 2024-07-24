# WeatherApp

## 프로젝트 소개

OpenWeatherAPI 를 이용한 날씨조회 앱

<br>

## 📑 목차

- [🖥️ 개발환경](#🖥%EF%B8%8F-개발-환경)
- [🔑 핵심기술](#%F0%9F%94%91-핵심-기술)
- [🔭 프로젝트 구조](#🔭-프로젝트-구조)
- [📱 실행화면](#📱-실행화면)
- [🛠 트러블 슈팅](#🛠%EF%B8%8F-트러블-슈팅)

<br>

## 🖥️ 개발 환경

- Xcode 15
- Swift 5.8
- 배포타겟: iOS 15
- 의존성 관리: SPM

<br>

## 🔑 핵심 기술 

### 🗃️ 프레임워크
- UI : UIKit

### 🗂️ 외부 의존성
- 아키텍쳐 : MVVM
- 네트워킹 : Alamofire
- 오토레이아웃 : SnapKit
- ReactiveX : RxSwift, RxRelay, RxCocoa

<br>

## 🔭 프로젝트 구조

```
.
WeatherApp
├── Resources
│   ├── Assets.xcassets
│   ├── Base.lproj
│   ├── Debug.xcconfig
│   ├── Info.plist
│   └── reduced_citylist.json
└── Sources
    ├── Application
    │   ├── AppDelegate.swift
    |   ├── SceneDelegate.swift
    │   ├── BundleInfo.swift
    │   └── DIContainer
    │       ├── AppDIContainer.swift
    │       └── MainSceneDIContainer.swift
    ├── Data
    │   ├── DTOs
    │   │   ├── CityResponse.swift
    │   │   ├── DataMapping
    │   │   │   ├── CityResponse+Mapping.swift
    │   │   │   └── WeatherResponse+Mapping.swift
    │   │   └── WeatherResponse.swift
    │   ├── Repository
    │   │   ├── DefaultCityRepository.swift
    │   │   ├── DefaultWeatherRepository.swift
    │   │   └── WeatherRepository.swift
    │   ├── WeatherEndpoint.swift
    │   └── WeatherRequest.swift
    ├── Domain
    │   ├── Entities
    │   │   ├── FiveDayForecastCellData.swift
    │   │   ├── ThreeHourForecastCellData.swift
    │   │   ├── TopViewData.swift
    │   │   └── WeatherExtraInfoCellData.swift
    │   ├── Interfaces
    │   │   ├── CityRepository.swift
    │   │   └── WeatherRepository.swift
    │   └── UseCases
    │       ├── FetchCityUseCase.swift
    │       └── FetchWeatherUseCase.swift
    ├── Infrastructure
    │   ├── APIClient.swift
    │   └── Endpoint.swift
    ├── Presentation
    │   ├── MainScene
    │   │   ├── MainViewController.swift
    │   │   ├── MainViewModel.swift
    │   │   ├── Subviews
    │   │   │   ├── FiveDayForecastCell.swift
    │   │   │   ├── FiveDayForecastView.swift
    │   │   │   ├── ThreeHourForecastCell.swift
    │   │   │   ├── ThreeHourForecastView.swift
    │   │   │   ├── TopView.swift
    │   │   │   ├── WeatherExtraInfoCell.swift
    │   │   │   ├── WeatherExtraInfoView.swift
    │   │   │   └── WeatherMapView.swift
    │   └── SearchScene
    │       ├── SearchViewController.swift
    │       ├── SearchViewModel.swift
    │       └── Subviews
    │           └── SearchQueryCell.swift
    └── Utils
        ├── BaseView.swift
        ├── BaseViewController.swift
        ├── Console.swift
        ├── Extensions
        │   ├── Date+.swift
        │   ├── Double+.swift
        │   ├── Encodable+.swift
        │   ├── Int+.swift
        │   └── UIViewController+.swift
        ├── LoadingView.swift
        └── ReusableCell.swift
```

<br>

## 📱 실행화면
    
### 홈 화면
|메인화면|검색화면|
|:---:|:---:|
|<img src="https://github.com/user-attachments/assets/7b1b419b-03ec-4ec2-b454-1387751448d0" width="200">|<img src="https://github.com/user-attachments/assets/4be02e4e-f6ec-413f-9eea-b452010cfa23" width="200">|

<br>

## 🛠️ 트러블 슈팅

### ⚠️ 검색어 입력에 따른 필터링
- 검색어 입력 시, 짧은 주기로 필터링 로직을 수행하게 되면 비용이 많이드는 문제점 존재
- RxSwift 의 debounce 메서드를 이용하여 주기를 조절하여 해결 

### ⚠️ 검색화면 키보드 가림문제
- 검색어 입력 시, 필터링된 검색쿼리 리스트의 하단부가 가려지는 문제
- 키보드가 띄워지고 내려가는 시점을 구독하여 키보드 높이만큼 tableView의contentInset bottom 을 조절해주어 해결

### ⚠️ 검색 후 데이터 바뀔때 어색함
- 검색 결과화면 표출 시 뚝 끊기며 바뀌는 어색함 존재
- 로딩뷰와 opacity조절 애니메이션을 이용해 자연스럽게 적용
