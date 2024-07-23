//
//  WeatherRepository.swift
//  WeatherApp
//
//  Created by 이원빈 on 2024/07/23.
//

import RxSwift

protocol WeatherRepository {
    func fetchWeather(param: WeatherRequest) -> Single<WeatherResponse>
}
