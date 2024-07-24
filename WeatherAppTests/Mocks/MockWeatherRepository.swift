//
//  MockWeatherRepository.swift
//  WeatherAppTests
//
//  Created by 이원빈 on 2024/07/24.
//

@testable import WeatherApp
import RxSwift

struct MockWeatherRepository: WeatherRepository {
    var response: Single<WeatherResponse> = .never()
    
    func fetchWeather(param: WeatherRequest) -> Single<WeatherResponse> {
        return response.delay(.milliseconds(500), scheduler: MainScheduler.instance)
    }
}
