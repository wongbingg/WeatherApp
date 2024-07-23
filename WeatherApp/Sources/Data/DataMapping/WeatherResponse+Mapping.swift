//
//  WeatherResponse+Mapping.swift
//  WeatherApp
//
//  Created by 이원빈 on 2024/07/23.
//

import Foundation

extension WeatherResponse {
    
    func toTopViewData() -> TopViewData {
        // TODO: 가장 최근 데이터를 표출해야함.
        .init(cityName: city.name,
              temperature: "\(list.first!.main.temp.toCelsius())",
              weather: "\(list.first!.weather.first!.description)",
              maximumTemperature: "\(list.first!.main.temp_max.toCelsius())",
              minimumTemperature: "\(list.first!.main.temp_min.toCelsius())")
    }
    
    func toThreeHourForecastCellData() -> [ThreeHourForecastCellData] {
        var twoDaysList = Array(list[0...15]) // 이틀간 16개의 날씨데이터만 표출
        return twoDaysList.map {
            let date = Date.fromTimestamp($0.dt)
            let koreaDateString = date.toKoreaTimeString(format: "a hh시")
            
            return ThreeHourForecastCellData(
                time: koreaDateString,
                iconName: $0.weather.first!.icon,
                temperature: $0.main.temp.toCelsius()
            )
        }
    }
    
    func toDailyForecastCellData() -> [DailyForecastCellData] {
        var standardDate = Date() // 기준날짜
        var tempList = [Double]()
        var dataList = [DailyForecastCellData]()
        
        list.forEach {
            let targetDate = Date.fromTimestamp($0.dt)
            
            if standardDate.isSameDay(as: targetDate) {
                tempList.append($0.main.temp)
            } else {
                let maxTemp = tempList.max()?.toCelsius() ?? "NONE"
                let minTemp = tempList.min()?.toCelsius() ?? "NONE"
                
                let cellData = DailyForecastCellData(
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
        
        let cellData = DailyForecastCellData(
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
        
        let humidityAverage = list.map { Int($0.main.humidity) }.reduce(0, +) / list.count
        let cloudsAverage = list.map { Int($0.clouds.all) }.reduce(0, +) / list.count
        let windAverage = list.map {
            maximumWind = $0.wind.speed
            return $0.wind.speed
        }.reduce(0.0, +) / Double(list.count)
        
        let windAverageString = String(format: "%.2fm/s", windAverage)
        let maximumWindString = String(format: "강풍: %.2fm/s", maximumWind)
        
        let pressureAverage = list.map { Int($0.main.pressure) }.reduce(0, +) / list.count
        
        return [
            .init(header: "습도", value: "\(humidityAverage)%", footer: nil),
            .init(header: "구름", value: "\(cloudsAverage)%", footer: nil),
            .init(header: "바람속도", value: windAverageString, footer: maximumWindString),
            .init(header: "기압", value: "\(pressureAverage.toCommaNumberString())\nhpa", footer: nil)
            
        ]
    }
}
