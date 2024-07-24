//
//  FetchWeatherUseCaseTests.swift
//  WeatherAppTests
//
//  Created by 이원빈 on 2024/07/24.
//

@testable import WeatherApp
import XCTest

import RxSwift
import Alamofire

final class FetchWeatherUseCaseTests: XCTestCase {
    
    var sut: FetchWeatherUseCase!
    var mockWeatherRepository: MockWeatherRepository!
    var disposeBag: DisposeBag!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        disposeBag = DisposeBag()
        mockWeatherRepository = MockWeatherRepository()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        mockWeatherRepository = nil
        disposeBag = nil
        try super.tearDownWithError()
    }
    
    func test_FetchWeatherUseCase요청_성공시_정확한값을받아오는지() {
        //given
        let requestParameter = WeatherRequest(lat: 0, lon: 0, appid: "", cnt: 0, lang: "")
        let preparedResponse = WeatherResponse.stub(cod: "test")
        mockWeatherRepository.response = .just(preparedResponse)
        sut = DefaultFetchWeatherUseCase(repository: mockWeatherRepository)
        
        // when
        let expectation = self.expectation(description: "Success Response")
        
        sut.execute(param: requestParameter)
            .subscribe { response in
                //then
                XCTAssertEqual(preparedResponse, response)
                expectation.fulfill()
            } onFailure: { error in
                Console.error(error.localizedDescription)
                XCTFail("Expected success but got error \(error)")
            }
            .disposed(by: disposeBag)
        
        waitForExpectations(timeout: 1.0)
    }
    
    func test_FetchWeatherUseCase요청_실패시_정확한오류를받아오는지() {
        //given
        let requestParameter = WeatherRequest(lat: 0, lon: 0, appid: "", cnt: 0, lang: "")
        let preparedError = AFError.explicitlyCancelled
        mockWeatherRepository.response = .error(preparedError)
        sut = DefaultFetchWeatherUseCase(repository: mockWeatherRepository)
        
        // when
        let expectation = self.expectation(description: "Failure Response")
        
        sut.execute(param: requestParameter)
            .subscribe { response in
                XCTFail("Expected failure but got response \(response)")
            } onFailure: { error in
                //then
                XCTAssertEqual(preparedError, error as! AFError)
                Console.error(error.localizedDescription)
                expectation.fulfill()
            }
            .disposed(by: disposeBag)
        
        waitForExpectations(timeout: 1.0)
    }
}
