//
//  UserDefaultsFetchUserBiometricsServiceTests.swift
//  UserBiometricsFeature
//
//  Created by Tak Mazarura on 26/05/2025.
//

import XCTest
import CoreHealthMaxModels
@testable import UserBiometricsFeature

final class UserDefaultsFetchUserBiometricsServiceTests: XCTestCase {}

// MARK: - FetchUserBiometricsServiceTestsSpec
extension UserDefaultsFetchUserBiometricsServiceTests: FetchUserBiometricsServiceTestsSpec {
    func test_getGender_returnsStoredValue() async {
        let expected = "female"

        let sut = make_sut()
        
        UserDefaults.standard.set(expected, forKey: UserBiometricKeys.gender.rawValue)
        let result = await sut.getGender()

        XCTAssertResultSuccess(result, equals: expected)
    }

    func test_getBirthday_returnsStoredValue() async {
        let expected = Date()
        
        let sut = make_sut()
        
        UserDefaults.standard.set(expected, forKey: UserBiometricKeys.birthday.rawValue)
        let result = await sut.getBirthday()

        XCTAssertResultSuccess(result, equals: expected)
    }

    func test_getHeight_returnsStoredValue() async {
        let expected = 180.5

        let sut = make_sut()
        
        UserDefaults.standard.set(expected, forKey: UserBiometricKeys.height.rawValue)
        let result = await sut.getHeight()

        XCTAssertResultSuccess(result, equals: expected)
    }

    func test_getWeight_returnsStoredValue() async {
        let expected = 78

        let sut = make_sut()
        
        UserDefaults.standard.set(expected, forKey: UserBiometricKeys.weight.rawValue)
        let result = await sut.getWeight()

        XCTAssertResultSuccess(result, equals: expected)
    }

    func test_getBloodType_returnsStoredValue() async {
        let expected = "A+"

        let sut = make_sut()
        
        UserDefaults.standard.set(expected, forKey: UserBiometricKeys.bloodType.rawValue)
        let result = await sut.getBloodType()

        XCTAssertResultSuccess(result, equals: expected)
    }

    func test_fetchAllMetrics_returnsAllNonNilMetrics() async {
        let sut = make_sut()
        
        let values: [String: Any] = [
            UserBiometricKeys.gender.rawValue: "male",
            UserBiometricKeys.birthday.rawValue: Date(),
            UserBiometricKeys.height.rawValue: 170.0,
            UserBiometricKeys.weight.rawValue: 70,
            UserBiometricKeys.bloodType.rawValue: "O+"
        ]
        values.forEach { UserDefaults.standard.set($0.value, forKey: $0.key) }
        
        let result = await sut.fetchAllMetrics()

        switch result {
        case .success(let metrics):
            XCTAssertEqual(metrics.count, 5)
        case .failure:
            XCTFail("Expected success with 5 metrics, got failure")
        }
    }

    func test_fetchAllMetrics_returnsFailureWhenAllAreMissing() async {
        clearUserDefaults()

        let sut = make_sut()
        let result = await sut.fetchAllMetrics()

        switch result {
        case .success:
            XCTFail("Expected failure when all values are missing")
        case .failure(let error):
            XCTAssertTrue(error is UserDefaultsFetchUserBiometricsService.BiometricFetchError)
        }
    }
}

// MARK: - Helpers
extension UserDefaultsFetchUserBiometricsServiceTests {
    func make_sut() -> UserDefaultsFetchUserBiometricsService {
        clearUserDefaults()
        return UserDefaultsFetchUserBiometricsService()
    }

    func clearUserDefaults() {
        let keys = [
            UserBiometricKeys.gender.rawValue,
            UserBiometricKeys.birthday.rawValue,
            UserBiometricKeys.height.rawValue,
            UserBiometricKeys.weight.rawValue,
            UserBiometricKeys.bloodType.rawValue
        ]
        keys.forEach { UserDefaults.standard.removeObject(forKey: $0) }
    }
}
