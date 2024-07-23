//
//  TopViewData.swift
//  WeatherApp
//
//  Created by 이원빈 on 2024/07/23.
//

struct TopViewData {
    let cityName: String
    let temperature: String
    let weather: String
    let maximumTemperature: String
    let minimumTemperature: String
    
    static func stub() -> Self {
        .init(cityName: "Busan", temperature: "7", weather: "맑음", maximumTemperature: "-7", minimumTemperature: "11")
    }
}
