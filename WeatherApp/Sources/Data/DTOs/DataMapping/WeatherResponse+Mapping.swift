//
//  WeatherResponse+Mapping.swift
//  WeatherApp
//
//  Created by 이원빈 on 2024/07/23.
//

import Foundation

extension WeatherResponse {
    
    func toTopViewData() -> TopViewData {

        guard let recentData = list.first else { return .stub() }
        
        return .init(cityName: city.name,
              temperature: "\(recentData.main.temp.toCelsius())",
              weather: "\(recentData.weather.first?.description ?? "보통")",
              maximumTemperature: "\(recentData.main.temp_max.toCelsius())",
              minimumTemperature: "\(recentData.main.temp_min.toCelsius())")
    }
    
    func toThreeHourForecastCellData() -> [ThreeHourForecastCellData] {
        let twoDaysList = Array(list[0...15])
        return twoDaysList.map {
            let date = Date.fromTimestamp($0.dt)
            let koreaDateString = date.toKoreaTimeString(format: "a hh시")
            var icon =  $0.weather.first?.icon ?? "01d"
            
            if icon.last == Character("n") {
                _ = icon.popLast()
                icon.append("d")
            }
            
            return ThreeHourForecastCellData(
                time: koreaDateString,
                iconName: icon,
                temperature: $0.main.temp.toCelsius()
            )
        }
    }
    
    func toDailyForecastCellData() -> [FiveDayForecastCellData] {
        var standardDate = Date()
        var tempList = [Double]()
        var dataList = [FiveDayForecastCellData]()
        
        list.forEach {
            let targetDate = Date.fromTimestamp($0.dt)
            
            if standardDate.isSameDay(as: targetDate) {
                tempList.append($0.main.temp)
            } else {
                let maxTemp = tempList.max()?.toCelsius() ?? "NONE"
                let minTemp = tempList.min()?.toCelsius() ?? "NONE"
                
                let cellData = FiveDayForecastCellData(
                    day: standardDate.toKoreaTimeString(format: "E"),
                    iconName: "01d",
                    minimumTemperature: minTemp,
                    maximumTemperature: maxTemp)
                
                dataList.append(cellData)
                standardDate = targetDate
            }
        }
        let maxTemp = tempList.max()?.toCelsius() ?? "NONE"
        let minTemp = tempList.min()?.toCelsius() ?? "NONE"
        
        let cellData = FiveDayForecastCellData(
            day: standardDate.toKoreaTimeString(format: "E"),
            iconName: "01d",
            minimumTemperature: minTemp,
            maximumTemperature: maxTemp)
        
        dataList.append(cellData)
        
        return dataList
    }
    
    func toMapData() -> (lat: Double, lon: Double) {
        return (city.coord.lat, city.coord.lon)
    }
    
    func toWeatherExtraInfoCellData() -> [WeatherExtraInfoCellData] {

        var maximumWind: Double = 0 {
            didSet {
                if oldValue > maximumWind {
                    maximumWind = oldValue
                }
            }
        }
        
        let count = list.count
        
        let humidityAverage = list.map { Int($0.main.humidity) }.reduce(0, +) / count
        let cloudsAverage = list.map { Int($0.clouds.all) }.reduce(0, +) / count
        let windAverage = list.map {
            maximumWind = $0.wind.speed
            return $0.wind.speed
        }.reduce(0.0, +) / Double(count)
        
        let windAverageString = String(format: "%.2fm/s", windAverage)
        let maximumWindString = String(format: "강풍: %.2fm/s", maximumWind)
        
        let pressureAverage = list.map { Int($0.main.pressure) }.reduce(0, +) / count
        
        return [
            .init(header: "습도", value: "\(humidityAverage)%", footer: nil),
            .init(header: "구름", value: "\(cloudsAverage)%", footer: nil),
            .init(header: "바람속도", value: windAverageString, footer: maximumWindString),
            .init(header: "기압", value: "\(pressureAverage.toCommaNumberString())\nhpa", footer: nil)
        ]
    }
}
