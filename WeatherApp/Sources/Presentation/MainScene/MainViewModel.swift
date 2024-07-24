//
//  MainViewModel.swift
//  WeatherApp
//
//  Created by 이원빈 on 7/22/24.
//

import RxSwift
import RxRelay

protocol MainViewModelInput {
    func fetchWeather(param: WeatherRequest)
    func putSearchText(_ text: String)
}

protocol MainViewModelOutput {
    var searchText: BehaviorRelay<String> { get }
    var topViewData: BehaviorRelay<TopViewData> { get }
    var threeHourForecastCellData: BehaviorRelay<[ThreeHourForecastCellData]> { get }
    var dailyForecastCellData: BehaviorRelay<[FiveDayForecastCellData]> { get }
    var mapData: BehaviorRelay<(lat: Double, lon: Double)> { get }
    var weatherExtraInfoCellData: BehaviorRelay<[WeatherExtraInfoCellData]> { get }
}

protocol MainViewModel: MainViewModelInput, MainViewModelOutput {}

// MARK: Outputs
struct DefaultMainViewModel: MainViewModel {
    var searchText: BehaviorRelay<String> = .init(value: "")
    var topViewData: BehaviorRelay<TopViewData> = .init(value: .stub())
    var threeHourForecastCellData: BehaviorRelay<[ThreeHourForecastCellData]> = .init(value: [])
    var dailyForecastCellData: BehaviorRelay<[FiveDayForecastCellData]> = .init(value: [])
    var mapData: BehaviorRelay<(lat: Double, lon: Double)> = .init(value: (0,0))
    var weatherExtraInfoCellData: BehaviorRelay<[WeatherExtraInfoCellData]> = .init(value: [])
    
    private var disposeBag = DisposeBag()
    private let fetchWeatherUseCase: FetchWeatherUseCase
    
    init(fetchWeatherUseCase: FetchWeatherUseCase) {
        self.fetchWeatherUseCase = fetchWeatherUseCase
    }
}

// MARK: Inputs
extension DefaultMainViewModel {
    
    func fetchWeather(param: WeatherRequest) {
        fetchWeatherUseCase.execute(param: param)
            .subscribe { response in
                topViewData.accept(response.toTopViewData())
                threeHourForecastCellData.accept(response.toThreeHourForecastCellData())
                dailyForecastCellData.accept(response.toDailyForecastCellData())
                mapData.accept(response.toMapData())
                weatherExtraInfoCellData.accept(response.toWeatherExtraInfoCellData())
            } onFailure: { error in
                Console.error(error.localizedDescription + " --- \(#function)")
            }
            .disposed(by: disposeBag)
    }
    
    func putSearchText(_ text: String) {
        searchText.accept(text)
    }
}
