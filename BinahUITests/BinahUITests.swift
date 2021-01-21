//
//  BinahUITests.swift
//  BinahUITests
//
//  Created by Adar Tzeiri on 18/01/2021.
//

import XCTest


class BinahUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
       continueAfterFailure = false

      app = XCUIApplication()
      app.launch()
    }
    
    func testNavbarTitleOnUnansweredTap() {
        // given
        let app = XCUIApplication()
        
        // when
        app.buttons["Unanswered"].tap()
        
        // then
        XCTAssertTrue(app.navigationBars["Unanswered"].staticTexts["Unanswered"].exists)
    }
    
    func testNavbarTitleOnAnsweredTap() {
        // given
        let app = XCUIApplication()
        
        // when
        app.buttons["Answered"].tap()
        
        // then
        XCTAssertTrue(app.navigationBars["Answered"].staticTexts["Answered"].exists)
    }
}

 
