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
}

protocol MainViewModelOutput {
    var topViewData: BehaviorRelay<TopViewData> { get }
    var threeHourForecastCellData: BehaviorRelay<[ThreeHourForecastCellData]> { get }
    var dailyForecastCellData: BehaviorRelay<[DailyForecastCellData]> { get }
    var weatherExtraInfoCellData: BehaviorRelay<[WeatherExtraInfoCellData]> { get }
}

protocol MainViewModel: MainViewModelInput, MainViewModelOutput {}

struct DefuaultMainViewModel: MainViewModel {
    private var disposeBag = DisposeBag()
    // MARK: Outputs
    var topViewData: BehaviorRelay<TopViewData> = .init(value: .stub())
    var threeHourForecastCellData: BehaviorRelay<[ThreeHourForecastCellData]> = .init(value: [])
    var dailyForecastCellData: BehaviorRelay<[DailyForecastCellData]> = .init(value: [])
    var weatherExtraInfoCellData: BehaviorRelay<[WeatherExtraInfoCellData]> = .init(value: [])
    
    private let fetchWeatherUseCase: FetchWeatherUseCase
    
    init(fetchWeatherUseCase: FetchWeatherUseCase) {
        self.fetchWeatherUseCase = fetchWeatherUseCase
    }
    
    // MARK: Inputs
    func fetchWeather(param: WeatherRequest) {
        fetchWeatherUseCase.execute(param: param)
            .subscribe { response in
                topViewData.accept(response.toTopViewData())
                threeHourForecastCellData.accept(response.toThreeHourForecastCellData())
                dailyForecastCellData.accept(response.toDailyForecastCellData())
                weatherExtraInfoCellData.accept(response.toWeatherExtraInfoCellData())
            } onFailure: { error in
                Console.error(error.localizedDescription + " --- \(#function)")
            }
            .disposed(by: disposeBag)
    }
}
