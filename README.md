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
|<img src="https://hackmd.io/_uploads/S1tdbVCuR.png" width="200">|<img src="https://hackmd.io/_uploads/Byd7fECuC.png" width="200">|

<br>

## 🛠️ 트러블 슈팅

### ⚠️ 검색어 입력에 따른 필터링
- 검색어 입력 시, 짧은 주기로 필터링 로직을 수행하게 되면 비용이 많이드는 문제점 존재
- RxSwift 의 debounce 메서드를 이용하여 주기를 조절하여 해결 



