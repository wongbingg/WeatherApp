//
//  CityResponse+Mapping.swift
//  WeatherApp
//
//  Created by 이원빈 on 2024/07/23.
//

import Foundation

extension CityResponse {
    func toSearchQueryCellData() -> SearchQueryCellData {
        .init(cityName: name, countryCode: country, lat: coord.lat, lon: coord.lon)
    }
}
