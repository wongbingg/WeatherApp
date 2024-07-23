//
//  ThreeHourForecastCellData.swift
//  WeatherApp
//
//  Created by 이원빈 on 2024/07/23.
//

struct ThreeHourForecastCellData {
    let time: String
    let iconName: String
    // TODO: 로컬 리소스에 없으면 api 로 받아오기.
    //https://openweathermap.org/img/wn/10d@2x.png
    let temperature: String
    
    static func stub() -> Self {
        .init(time: "오전 11시", iconName: "01d", temperature: "-7")
    }
}
