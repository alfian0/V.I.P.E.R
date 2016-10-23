//
//  TooDoAppUITests.swift
//  TooDoAppUITests
//
//  Created by admin on 23/09/16.
//  Copyright © 2016 com.ios. All rights reserved.
//

import XCTest
import Quick
import Nimble
import SBTUITestTunnel


class TooDoAppUITests: XCTestCase {
        
    var app:SBTUITunneledApplication!
    
    override func setUp() {
        XCUIApplication().terminate()
        super.setUp()
        app = SBTUITunneledApplication()
        app.launchTunnel()
        continueAfterFailure = false
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testRegistration() {
        
        let matcher = SBTRequestMatch.URL("/register",method:"POST")
        app.stubRequestsMatching(matcher, returnJsonNamed:"registration_response.json", returnCode:200 ,responseTime:SBTUITunnelStubsDownloadSpeed3G)
        
        let expectation = expectationWithDescription("Query timed out.");
        app.waitForMonitoredRequestsMatching(matcher,timeout:1, completionBlock:{ result in
            expectation.fulfill();
        })

        app.buttons["Sign Up"].tap()
        app.textFields["Email"].tap()
        app.textFields["Email"].typeText("test@test.com")
        
        UIPasteboard.generalPasteboard().string = "password"
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.pressForDuration(1.1)
        app.menuItems["Paste"].tap()

        UIPasteboard.generalPasteboard().string = "password"
        let confirmPasswordSecureTextField = app.secureTextFields["Confirm Password"]
        confirmPasswordSecureTextField.pressForDuration(1.1)
        app.menuItems["Paste"].tap()
        
        app.navigationBars["Sign Up"].buttons["Done"].tap()
        
        waitForExpectationsWithTimeout(10,handler:nil)
        
        assert(app.staticTexts["Todo List"].exists)
        
    }
    
}

