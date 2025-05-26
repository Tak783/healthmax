//
//  HealthMetricTypeUnitTests.swift
//  CoreHealthMaxModels
//
//  Created on 26/05/2025.
//

import XCTest
import CoreHealthMaxModels

final class HealthMetricTypeTests: XCTestCase {
    func test_displayNamesAreCorrect() {
        XCTAssertEqual(HealthMetricType.weight.displayName, "Weight")
        XCTAssertEqual(HealthMetricType.steps.displayName, "Steps")
        XCTAssertEqual(HealthMetricType.birthday.displayName, "Birthday")
    }

    func test_iconsAreCorrectTypes() {
        XCTAssertEqual(HealthMetricType.weight.icon.name, "scalemass.fill")
        XCTAssertEqual(HealthMetricType.weight.icon.type, .system)

        XCTAssertEqual(HealthMetricType.bloodType.icon.name, "🩸")
        XCTAssertEqual(HealthMetricType.bloodType.icon.type, .emoji)
    }

    func test_allCasesAreUnique() {
        let uniqueSet = Set(HealthMetricType.allCases.map { $0.rawValue })
        XCTAssertEqual(uniqueSet.count, HealthMetricType.allCases.count)
    }
}
