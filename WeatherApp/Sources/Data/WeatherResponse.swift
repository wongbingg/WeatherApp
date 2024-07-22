//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by 이원빈 on 2024/07/22.
//

import Foundation

struct WeatherResopnse: Decodable {
    let cod: String
    let message: Double
    let cnt: Double
    let list: [Data]
    let city: City
}

extension WeatherResopnse {
    
    struct Data: Decodable {
        let dt: Double
        let main: [Main]
        let weather: [Weather]
        let clouds: Clouds
        let wind: Wind
        let visibility: Double
        let pop: Double
        let sys: Sys
        let dt_txt: String
    }
    
    struct City: Decodable {
        let id: Double
        let name: String
        let coord: Coord
        let country: String
        let population: Double
        let timezone: Double
        let sunrise: Double
        let sunset: Double
    }
}

extension WeatherResopnse.Data {
    
    struct Main: Decodable {
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
    
    struct Weather: Decodable {
        let id: Double
        let main: String
        let description: String
        let icon: String
    }
    
    struct Clouds: Decodable {
        let all: Double
    }
    
    struct Wind: Decodable {
        let speed: Double
        let deg: Double
        let gust: Double
    }
    
    struct Sys: Decodable {
        let pod: String
    }
}

extension WeatherResopnse.City {
    
    struct Coord: Decodable {
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