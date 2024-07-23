//
//  Int+.swift
//  WeatherApp
//
//  Created by 이원빈 on 2024/07/23.
//

import Foundation

extension Int {
    func toCommaNumberString() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        guard let formattedNumber = numberFormatter.string(from: NSNumber(value: self)) else {
            return String(self)
        }
        return formattedNumber
    }
}
