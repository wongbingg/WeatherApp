//
//  AFError_+.swift
//  WeatherAppTests
//
//  Created by 이원빈 on 2024/07/24.
//

import Alamofire

extension AFError: Equatable {
    public static func == (lhs: Alamofire.AFError, rhs: Alamofire.AFError) -> Bool {
        lhs.localizedDescription == rhs.localizedDescription
    }
}
