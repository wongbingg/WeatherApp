//
//  FetchCityUseCase.swift
//  WeatherApp
//
//  Created by 이원빈 on 2024/07/23.
//

protocol FetchCityUseCase {
    func execute() -> [CityResponse]
}

final class DefaultFetchCityUseCase: FetchCityUseCase {
    private let cityRepository: CityRepository
    
    init(cityRepository: CityRepository) {
        self.cityRepository = cityRepository
    }
    
    func execute() -> [CityResponse] {
        cityRepository.fetchCityList()
    }
}
