//
//  APIClientTests.swift
//  WeatherAppTests
//
//  Created by 이원빈 on 2024/07/24.
//

@testable import WeatherApp
import XCTest

import RxSwift

final class APIClientTests: XCTestCase {
    
    var sut: APIClientProtocol!
    var disposeBag: DisposeBag!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = MockAPIClient()
        disposeBag = DisposeBag()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        disposeBag = nil
        try super.tearDownWithError()
    }
    
    func test_성공응답시_정확한값을받아오는지() {
        // given
        let stubClient = sut as! MockAPIClient
        let preparedData = ["key": "value"]
        stubClient.responseData = try! JSONSerialization.data(withJSONObject: preparedData)
        
        let endpoint = WeatherEndpoint()
        
        // when
        let expectation = self.expectation(description: "Success Response")
        
        sut.request(endpoint: endpoint)
            .subscribe { (response: [String: String]) in
                // then
                XCTAssertEqual(preparedData, response)
                expectation.fulfill()
            } onFailure: { error in
                XCTFail("Expected success but got error: \(error)")
            }
            .disposed(by: disposeBag)
        
        waitForExpectations(timeout: 1.0)
    }
    
    func test_실패응답시_정확한오류를받아오는지() {
        // given
        let stubClient = sut as! MockAPIClient
        stubClient.shouldReturnError = true
        
        let endpoint = WeatherEndpoint()
        
        // when
        let expectation = self.expectation(description: "Failure Response")
        
        sut.request(endpoint: endpoint)
            .subscribe { (response: [String: String]) in
                XCTFail("Expected failure but got success: \(response)")
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
