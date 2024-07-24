//
//  MockFetchWeatherUseCase.swift
//  WeatherAppTests
//
//  Created by 이원빈 on 2024/07/24.
//

@testable import WeatherApp

import RxSwift

struct MockFetchWeatherUseCase: FetchWeatherUseCase {
    var response: Single<WeatherResponse> = .never()
    
    func execute(param: WeatherRequest) -> Single<WeatherResponse> {
        return response.delay(.milliseconds(500), scheduler: MainScheduler.instance)
    }
}
