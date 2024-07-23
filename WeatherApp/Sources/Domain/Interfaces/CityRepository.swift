//
//  CityRepository.swift
//  WeatherApp
//
//  Created by 이원빈 on 2024/07/23.
//

protocol CityRepository {
    func fetchCityList() -> [CityResponse]
}
