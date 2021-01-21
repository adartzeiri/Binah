//
//  BinahAsyncTests.swift
//  BinahAsyncTests
//
//  Created by Adar Tzeiri on 21/01/2021.
//

import XCTest
@testable import Binah

class BinahAsyncTests: XCTestCase {

    var sut: FeedViewModel!
    
    override func setUp() {
      super.setUp()
        sut = FeedViewModel(endPoint: FeedEndPoint())
    }
    
    override func tearDown() {
      sut = nil
      super.tearDown()
    }
    
    func testFetchAnsweredFeedViewModels() {
        // given
        let promise = expectation(description: "Recieve feed data")
        sut.feedFilterType = .answered
        // when
        sut.fetchFeed()
        
        // then
        sut.dataSource.data.bind { (feedViewModels) in
            promise.fulfill()
        }
        
        sut.updateNoResultsFound.bind { (isEmpty) in
            XCTFail("No results have found")
        }
        
        wait(for: [promise], timeout: 5)
    }
    
    func testFetchUnansweredFeedViewModels() {
        // given
        let promise = expectation(description: "Recieve feed data")
        sut.feedFilterType = .unanswered
        
        // when
        sut.fetchFeed()
        
        // then
        sut.dataSource.data.bind { (feedViewModels) in
            promise.fulfill()
        }
        
        sut.updateNoResultsFound.bind { (isEmpty) in
            XCTFail("No results have found")
        }
        
        wait(for: [promise], timeout: 5)
    }

}
