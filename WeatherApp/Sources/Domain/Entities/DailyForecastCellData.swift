//
//  DailyForecastCellData.swift
//  WeatherApp
//
//  Created by 이원빈 on 2024/07/23.
//

struct DailyForecastCellData {
    let day: String
    let iconName: String
    let minimumTemperature: String
    let maximumTemperature: String
    
    static func stub() -> Self {
        .init(day: "수", iconName: "01d", minimumTemperature: "-7", maximumTemperature: "11")
    }
}
