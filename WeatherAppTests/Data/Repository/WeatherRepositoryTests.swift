//
//  WeatherRepositoryTests.swift
//  WeatherAppTests
//
//  Created by 이원빈 on 2024/07/24.
//

@testable import WeatherApp
import XCTest

import RxSwift

final class WeatherRepositoryTests: XCTestCase {
    
    var sut: WeatherRepository!
    var stubAPIClient: MockAPIClient!
    var disposeBag: DisposeBag!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        disposeBag = DisposeBag()
        stubAPIClient = MockAPIClient()
        sut = DefaultWeatherRepository(apiClient: stubAPIClient)
    }
    
    override func tearDownWithError() throws {
        stubAPIClient = nil
        sut = nil
        disposeBag = nil
        try super.tearDownWithError()
    }
    
    func test_날씨요청_성공시_정확한값을받아오는지() {
        // given
        let preparedResponse = WeatherResponse.stub()
        stubAPIClient.responseData = try! JSONEncoder().encode(preparedResponse)
        sut = DefaultWeatherRepository(apiClient: stubAPIClient)
        
        // when
        let expectation = self.expectation(description: "Success Response")
        
        let request = WeatherRequest(lat: 0, lon: 0, appid: "", cnt: 0, lang: "")
        sut.fetchWeather(param: request)
            .subscribe { response in
                // then
                XCTAssertEqual(preparedResponse, response)
                expectation.fulfill()
            } onFailure: { error in
                XCTFail("Expected success but got error \(error)")
            }
            .disposed(by: disposeBag)

        waitForExpectations(timeout: 1.0)
    }
    
    func test_날씨요청_실패시_정확한오류를받아오는지() {
        // given
        stubAPIClient.shouldReturnError = true
        sut = DefaultWeatherRepository(apiClient: stubAPIClient)
        
        // when
        let expectation = self.expectation(description: "Failure Response")
        
        let request = WeatherRequest(lat: 0, lon: 0, appid: "", cnt: 0, lang: "")
        sut.fetchWeather(param: request)
            .subscribe { response in
                XCTFail("Expected failure but got error \(response)")
            } onFailure: { error in
                // then
                XCTAssertNotNil(error)
                Console.debug(error.localizedDescription)
                expectation.fulfill()
            }
            .disposed(by: disposeBag)

        waitForExpectations(timeout: 1.0)
    }
}
