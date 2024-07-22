//
//  WeatherRepository.swift
//  WeatherApp
//
//  Created by 이원빈 on 2024/07/22.
//

import RxSwift

protocol WeatherRepository {
    func fetchWeather(param: WeatherRequest) -> Single<WeatherResopnse>
}

final class DefaultWeatherRepository: WeatherRepository {
    
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
    
    func fetchWeather(param: WeatherRequest) -> Single<WeatherResopnse> {
        do {
            let parameters = try param.toDictionary()
            let endpoint = WeatherEndpoint(parameters: parameters)
            return apiClient.request(endpoint: endpoint)
        } catch {
            return .error(error)
        }
    }
}
