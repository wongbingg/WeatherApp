//
//  WeatherEndpoint.swift
//  WeatherApp
//
//  Created by 이원빈 on 2024/07/22.
//

import Alamofire

struct WeatherEndpoint: Endpoint {
    var baseURL: String = "https://api.openweathermap.org"
    var path: String = "/data/2.5/forecast"
    var method: HTTPMethod = .get
    var parameters: [String : Any]?
    var headers: HTTPHeaders? = nil
}

