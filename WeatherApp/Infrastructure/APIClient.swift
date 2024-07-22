//
//  APIClient.swift
//  WeatherApp
//
//  Created by 이원빈 on 2024/07/22.
//

import Alamofire
import RxSwift

protocol APIClientProtocol {
    func request<T: Decodable>(endpoint: Endpoint) -> Single<T>
}

final class APIClient: APIClientProtocol {
    
    func request<T>(endpoint: Endpoint) -> Single<T> where T : Decodable {
        
        Single.create { single in
            
            let request = AF.request(
                endpoint.url,
                method: HTTPMethod(rawValue: endpoint.method.rawValue),
                parameters: endpoint.parameters,
                encoding: URLEncoding.default,
                headers: endpoint.headers
            )
            .validate(statusCode: 200..<300)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    single(.success(value))
                case .failure(let error):
                    single(.failure(error))
                }
            }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
}
