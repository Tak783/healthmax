//
//  HealthMetricValueUnitTests.swift
//  CoreHealthMaxModels
//
//  Created by Tak Mazarura on 26/05/2025.
//

import XCTest
import CoreHealthMaxModels

final class HealthMetricValueTests: XCTestCase {
    func test_defaultStringValue_int() {
        let metric = HealthMetricValue.int(42)
        XCTAssertEqual(metric.defaultStringValue, "42")
    }

    func test_defaultStringValue_double() {
        let metric = HealthMetricValue.double(72.3456)
        XCTAssertEqual(metric.defaultStringValue, "72.35")
    }

    func test_defaultStringValue_string() {
        let metric = HealthMetricValue.string("Test")
        XCTAssertEqual(metric.defaultStringValue, "Test")
    }

    func test_defaultStringValue_bool() {
        XCTAssertEqual(HealthMetricValue.bool(true).defaultStringValue, "Yes")
        XCTAssertEqual(HealthMetricValue.bool(false).defaultStringValue, "No")
    }

    func test_defaultStringValue_date() {
        let date = Date(timeIntervalSince1970: 0) // Jan 1, 1970
        let formatter = DateFormatter.readableDayOnlyDateFormatter
        let expected = formatter.string(from: date)

        let metric = HealthMetricValue.date(date)
        XCTAssertEqual(metric.defaultStringValue, expected)
    }
}
