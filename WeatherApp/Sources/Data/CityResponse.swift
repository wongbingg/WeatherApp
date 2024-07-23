//
//  CityResponse.swift
//  WeatherApp
//
//  Created by 이원빈 on 2024/07/23.
//

import Foundation

struct CityResponse: Decodable {
    let id: Double
    let name: String
    let country: String
    let coord: Coord
    
    struct Coord: Decodable {
        let lon: Double
        let lat: Double
    }
}
/*
 {
     "id": 7873004,
     "name": "Warth",
     "country": "AT",
     "coord": {
         "lon": 16.082741,
         "lat": 47.6422
     }
 }
 */
