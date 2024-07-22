//
//  WeatherRequest.swift
//  WeatherApp
//
//  Created by 이원빈 on 2024/07/22.
//

import Foundation

struct WeatherRequest: Encodable {
    let lat: Double
    let lon: Double
    let appid: String
}
