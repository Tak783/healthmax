//
//  UserBiometricKeysUnitTests.swift
//  CoreHealthMaxModels
//
//  Created on 26/05/2025.
//

import XCTest
import CoreHealthMaxModels

final class UserBiometricKeysTests: XCTestCase {
    func test_allKeysHaveCorrectRawValues() {
        XCTAssertEqual(UserBiometricKeys.gender.rawValue, "user_biometrics_gender")
        XCTAssertEqual(UserBiometricKeys.birthday.rawValue, "user_biometrics_birthday")
        XCTAssertEqual(UserBiometricKeys.height.rawValue, "user_biometrics_height")
        XCTAssertEqual(UserBiometricKeys.weight.rawValue, "user_biometrics_weight")
        XCTAssertEqual(UserBiometricKeys.bloodType.rawValue, "user_biometrics_bloodType")
    }
}
