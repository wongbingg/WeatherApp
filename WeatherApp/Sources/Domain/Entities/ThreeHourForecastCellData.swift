//
//  ThreeHourForecastCellData.swift
//  WeatherApp
//
//  Created by 이원빈 on 2024/07/23.
//

struct ThreeHourForecastCellData {
    let time: String
    let iconName: String
    let temperature: String
    
    static func stub() -> Self {
        .init(time: "오전 11시", iconName: "01d", temperature: "-7")
    }
}
