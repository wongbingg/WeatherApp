//
//  Double+.swift
//  WeatherApp
//
//  Created by 이원빈 on 2024/07/23.
//

import Foundation

extension Double {
    // kelvin 온도를 섭씨 온도로 변환하는 함수
    func toCelsius() -> String {
        return String(format: "%.1f", self - 273.15)
    }
}
