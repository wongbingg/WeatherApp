//
//  FetchWeatherUseCase.swift
//  WeatherApp
//
//  Created by 이원빈 on 7/22/24.
//

import RxSwift

protocol FetchWeatherUseCase {
    func execute(param: WeatherRequest) -> Single<WeatherResponse>
}

final class DefaultFetchWeatherUseCase: FetchWeatherUseCase {
    private let repository: WeatherRepository
    
    init(repository: WeatherRepository) {
        self.repository = repository
    }
    
    func execute(param: WeatherRequest) -> Single<WeatherResponse> {
        repository.fetchWeather(param: param)
    }
}
