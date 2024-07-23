//
//  CityRepository.swift
//  WeatherApp
//
//  Created by 이원빈 on 2024/07/23.
//

import Foundation

final class DefaultCityRepository: CityRepository {
    
    func fetchCityList() -> [CityResponse] {
        let fileName = "reduced_citylist"
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            // TODO: 오류 방출
            return []
        }
        
        do {
            let data = try Data(contentsOf: url)
            let cityList = try JSONDecoder().decode([CityResponse].self, from: data)
            // TODO: 결과값 반환
            return cityList
        } catch {
            // TODO: 오류방출
            Console.error(error.localizedDescription)
            return []
        }
    }
}
