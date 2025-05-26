//
//  LaunchViewUITests.swift
//  HealthMax
//
//  Created on 26/05/2025.
//

import XCTest

final class LaunchViewUITests: XCTestCase {
    private var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
}

// MARK: - UI Presence Tests
extension LaunchViewUITests {
    func test_welcomeTextsAreVisible() {
        XCTAssertTrue(app.staticTexts["Welcome to!"].waitForExistence(timeout: 2), "Welcome message should be visible")
        XCTAssertTrue(app.staticTexts["HEALTHMAX.AI"].exists, "App title should be visible")
        XCTAssertTrue(app.staticTexts["Maximising your health\nmade easy"].exists, "Subtitle should be visible")
    }

    func test_getStartedButtonIsVisibleAndTappable() {
        let button = app.buttons["Get Started"]
        XCTAssertTrue(button.exists, "Get Started button should be visible")
        XCTAssertTrue(button.isHittable, "Get Started button should be tappable")
    }
}
