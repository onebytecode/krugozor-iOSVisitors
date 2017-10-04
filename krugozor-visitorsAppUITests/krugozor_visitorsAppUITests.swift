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

        let app = XCUIApplication()
        let element2 = app.otherElements.containing(.pageIndicator, identifier:"page 1 of 3").children(matching: .other).element
        let element = element2.children(matching: .other).element.children(matching: .other).element
        element.swipeLeft()
        // Почему падает тест
        element.swipeLeft()
        element2.children(matching: .other).element(boundBy: 0).children(matching: .other).element/*@START_MENU_TOKEN@*/.swipeRight()/*[[".swipeUp()",".swipeRight()"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        app.textFields["oliver@"].typeText("fffff@gmail.com")

        let passwordSecureTextField = app.secureTextFields["password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("123123")
        app.buttons["Login"].tap()

        let elementsQuery = app.scrollViews.otherElements
        let alexTextField = elementsQuery.textFields["Alex"]
        alexTextField.tap()
        alexTextField.typeText("efwef")

        let simonovTextField = elementsQuery.textFields["Simonov"]
        simonovTextField.tap()
        simonovTextField.tap()
        simonovTextField.typeText("wefwef")

        let textField = elementsQuery.textFields["+7 (925) 555-55-55"]
        textField.tap()
        textField.tap()
        textField.typeText("79999999999")

        let textField2 = elementsQuery.textFields["17.09.1995"]
        textField2.tap()
        textField2.tap()
        textField2.typeText("11111991")
        app/*@START_MENU_TOKEN@*/.buttons["Register"]/*[[".scrollViews.buttons[\"Register\"]",".buttons[\"Register\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    }

}
