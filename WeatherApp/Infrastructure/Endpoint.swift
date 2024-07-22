//
//  Endpoint.swift
//  WeatherApp
//
//  Created by 이원빈 on 2024/07/22.
//

import Alamofire

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any]? { get }
    var headers: HTTPHeaders? { get }
}

extension Endpoint {
    var url: String {
        return baseURL + path
    }
}

