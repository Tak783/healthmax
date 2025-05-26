//
//  BloodTypeUnitTests.swift
//  CoreHealthMaxModels
//
//  Created on 26/05/2025.
//

import XCTest
import CoreHealthMaxModels

final class BloodTypeTests: XCTestCase {
    func test_allCasesHaveCorrectRawValuesAndIDs() {
        for bloodType in BloodType.allCases {
            XCTAssertEqual(bloodType.id, bloodType.rawValue)
            XCTAssertEqual(bloodType.displayName, bloodType.rawValue)
        }

        XCTAssertEqual(BloodType.aPositive.rawValue, "A+")
        XCTAssertEqual(BloodType.oNegative.rawValue, "O−")
    }

    func test_allCasesAreUnique() {
        let uniqueSet = Set(BloodType.allCases.map { $0.rawValue })
        XCTAssertEqual(uniqueSet.count, BloodType.allCases.count)
    }
}
