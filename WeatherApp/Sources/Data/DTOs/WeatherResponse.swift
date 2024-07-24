//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by 이원빈 on 2024/07/22.
//

import Foundation

struct WeatherResponse: Codable, Equatable {
    let cod: String
    let message: Double
    let cnt: Double
    let list: [ListData]
    let city: City
    
    static func stub(cod: String = "0", message: Double = 0, cnt: Double = 0, list: [ListData] = [], city: City = .stub()) -> Self {
        .init(cod: cod, message: message, cnt: cnt, list: list, city: city)
    }
}

extension WeatherResponse {
    
    struct ListData: Codable, Equatable {
        let dt: Double
        let main: Main
        let weather: [Weather]
        let clouds: Clouds
        let wind: Wind
        let visibility: Double
        let pop: Double
//        let rain: Rain
        let sys: Sys
        let dt_txt: String
    }
    
    struct City: Codable, Equatable {
        let id: Double
        let name: String
        let coord: Coord
        let country: String
        let population: Double
        let timezone: Double
        let sunrise: Double
        let sunset: Double
        
        static func stub(id: Double = 0, name: String = "", coord: Coord = .init(lat: 0, lon: 0), country: String = "", population: Double = 0, timezone: Double = 0, sunrise: Double = 0, sunset: Double = 0) -> Self {
            .init(id: id, name: name, coord: coord, country: country, population: population, timezone: timezone, sunrise: sunrise, sunset: sunset)
        }
    }
}

extension WeatherResponse.ListData {
    
    struct Main: Codable, Equatable {
        let temp: Double
        let feels_like: Double
        let temp_min: Double
        let temp_max: Double
        let pressure: Double
        let sea_level: Double
        let grnd_level: Double
        let humidity: Double
        let temp_kf: Double
    }
    
    struct Weather: Codable, Equatable {
        let id: Double
        let main: String
        let description: String
        let icon: String
    }
    
    struct Clouds: Codable, Equatable {
        let all: Double
    }
    
    struct Wind: Codable, Equatable {
        let speed: Double
        let deg: Double
        let gust: Double
    }
    
//    struct Rain {
//        let 3h: Double
//    }
    
    struct Sys: Codable, Equatable {
        let pod: String
    }
}

extension WeatherResponse.City {
    
    struct Coord: Codable, Equatable {
        let lat: Double
        let lon: Double
    }
}

/*
{
    "cod": "200",
    "message": 0,
    "cnt": 40,
    "list": [
        {
            "dt": 1721930400,
            "main": {
                "temp": 303.29,
                "feels_like": 307.34,
                "temp_min": 303.29,
                "temp_max": 303.29,
                "pressure": 1014,
                "sea_level": 1014,
                "grnd_level": 975,
                "humidity": 65,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 500,
                    "main": "Rain",
                    "description": "light rain",
                    "icon": "10d"
                }
            ],
            "clouds": {
                "all": 20
            },
            "wind": {
                "speed": 2.02,
                "deg": 211,
                "gust": 1.85
            },
            "visibility": 10000,
            "pop": 0.32,
            "rain": {
                "3h": 0.12
            },
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2024-07-25 18:00:00"
        }
    ],
    "city": {
        "id": 3595803,
        "name": "Escuintla",
        "coord": {
            "lat": 14.305,
            "lon": -90.785
        },
        "country": "GT",
        "population": 103165,
        "timezone": -21600,
        "sunrise": 1721562242,
        "sunset": 1721608486
    }
}

*/
