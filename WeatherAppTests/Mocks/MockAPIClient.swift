//
//  MockAPIClient.swift
//  WeatherAppTests
//
//  Created by 이원빈 on 2024/07/24.
//

@testable import WeatherApp
import Foundation

import RxSwift

final class MockAPIClient: APIClientProtocol {
    
    var responseData: Data = Data()
    var shouldReturnError: Bool = false
    var error: Error = NSError(domain: "com.example.error", code: -1, userInfo: nil)
    
    func request<T: Decodable>(endpoint: Endpoint) -> Single<T> {
        return Single.create { single in
            if self.shouldReturnError {
                single(.failure(self.error))
            } else {
                do {
                    let decodedObject = try JSONDecoder().decode(T.self, from: self.responseData)
                    single(.success(decodedObject))
                } catch let decodeError {
                    single(.failure(decodeError))
                }
            }
            return Disposables.create()
        }
    }
}
