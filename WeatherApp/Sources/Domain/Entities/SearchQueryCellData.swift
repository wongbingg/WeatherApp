//
//  SearchQueryCellData.swift
//  WeatherApp
//
//  Created by 이원빈 on 2024/07/24.
//

struct SearchQueryCellData {
    let cityName: String
    let countryCode: String
    let lat: Double
    let lon: Double
    
    static func stub() -> Self {
        .init(cityName: "Korea", countryCode: "Seoul", lat: 0, lon: 0)
    }
}
