//
//  krugozor_visitorsAppUITests.swift
//  krugozor-visitorsAppUITests
//
//  Created by Alexander Danilin on 25/09/2017.
//  Copyright © 2017 oneByteCode. All rights reserved.
//

import XCTest

class krugozor_visitorsAppUITests: XCTestCase {

    override func setUp() {
        super.setUp()

        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        
    }
    
    func testSegueBeetwinViewControllers () {
        let element = XCUIApplication().otherElements.containing(.pageIndicator, identifier:"page 1 of 3").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        element.swipeLeft()
        let element2 = XCUIApplication().otherElements.containing(.pageIndicator, identifier:"page 2 of 3").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        element2.swipeLeft()
        let app = XCUIApplication().otherElements.containing(.pageIndicator, identifier:"page 3 of 3").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        
        let oliverTextField = app.textFields["oliver@"]
        oliverTextField.tap()
        oliverTextField.typeText("wefefe@gwefe.de")
        
        let passwordSecureTextField = app.secureTextFields["password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("ацуацуа")
        app.buttons["Login"].tap()
        
        XCUIApplication()/*@START_MENU_TOKEN@*/.buttons["Register"]/*[[".scrollViews.buttons[\"Register\"]",".buttons[\"Register\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    }
}
