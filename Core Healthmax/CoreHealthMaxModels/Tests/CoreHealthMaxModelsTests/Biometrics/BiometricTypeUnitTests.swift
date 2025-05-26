//
//  BiometricUnitTypeTests.swift
//  CoreHealthMaxModels
//
//  Created by Tak Mazarura on 26/05/2025.
//

import XCTest
import CoreHealthMaxModels

final class BiometricTypeTests: XCTestCase {
    func test_biometricTypeHasCorrectRawValues() {
        XCTAssertEqual(BiometricType.bloodType.rawValue, 0)
        XCTAssertEqual(BiometricType.dateOfBirth.rawValue, 1)
        XCTAssertEqual(BiometricType.height.rawValue, 2)
        XCTAssertEqual(BiometricType.weight.rawValue, 3)
    }
}
