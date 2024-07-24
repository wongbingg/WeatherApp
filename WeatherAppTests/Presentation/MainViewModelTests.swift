//
//  MainViewModelTests.swift
//  WeatherAppTests
//
//  Created by 이원빈 on 2024/07/24.
//

@testable import WeatherApp
import XCTest

import RxSwift
import Alamofire

final class MainViewModelTests: XCTestCase {
    
    var sut: MainViewModel!
    var mockFetchWeatherUseCase: MockFetchWeatherUseCase!
    var disposeBag: DisposeBag!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        disposeBag = DisposeBag()
        mockFetchWeatherUseCase = MockFetchWeatherUseCase()
        
    }
    
    override func tearDownWithError() throws {
        sut = nil
        disposeBag = nil
        try super.tearDownWithError()
    }
    
    func test_putSearchText메서드_수행성공시_searchText에_accept되는지() {
        // given
        let inputText = "검색시, 입력값"
        mockFetchWeatherUseCase.response = .just(.stub())
        sut = DefaultMainViewModel(fetchWeatherUseCase: mockFetchWeatherUseCase)
        
        // when
        sut.putSearchText(inputText)
        
        // then
        XCTAssertEqual(sut.searchText.value, inputText)
    }
    
    func test_fetchWeather메서드_수행성공시_binding된_각Entity에_전달되는지() {
        // given
        let requestParam = WeatherRequest(lat: 0, lon: 0, appid: "", cnt: 0, lang: "")
        let preparedResponse = WeatherResponse.stub(cod: "test")
        mockFetchWeatherUseCase.response = .just(preparedResponse)
        sut = DefaultMainViewModel(fetchWeatherUseCase: mockFetchWeatherUseCase)
        
        // when
        let expectation1 = self.expectation(description: "Success Response1")
        let expectation2 = self.expectation(description: "Success Response2")
        let expectation3 = self.expectation(description: "Success Response3")
        let expectation4 = self.expectation(description: "Success Response4")
        
        sut.topViewData
            .subscribe { response in
                // then
                expectation3.fulfill()
            } onError: { error in
                Console.error(error.localizedDescription)
                XCTFail("Expected success but got error \(error)")
            }
            .disposed(by: disposeBag)
        
        sut.dailyForecastCellData
            .subscribe { response in
                // then
                expectation1.fulfill()
            } onError: { error in
                Console.error(error.localizedDescription)
                XCTFail("Expected success but got error \(error)")
            }
            .disposed(by: disposeBag)
        
        sut.threeHourForecastCellData
            .subscribe { response in
                // then
                expectation2.fulfill()
            } onError: { error in
                Console.error(error.localizedDescription)
                XCTFail("Expected success but got error \(error)")
            }
            .disposed(by: disposeBag)
        
        sut.weatherExtraInfoCellData
            .subscribe { response in
                // then
                expectation4.fulfill()
            } onError: { error in
                Console.error(error.localizedDescription)
                XCTFail("Expected success but got error \(error)")
            }
            .disposed(by: disposeBag)

        
        sut.fetchWeather(param: requestParam)
        
        waitForExpectations(timeout: 1.0)
    }
}
