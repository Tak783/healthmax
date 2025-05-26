//
//  UserDefaultsSaveUserBiometricsServiceUnitTests.swift
//  UserBiometricsFeature
//
//  Created by Tak Mazarura on 26/05/2025.
//

import XCTest
import CoreHealthMaxModels
@testable import UserBiometricsFeature

final class UserDefaultsSaveUserBiometricsServiceTests: XCTestCase {}

// MARK: - SaveUserBiometricsServiceTestsSpec
extension UserDefaultsSaveUserBiometricsServiceTests: SaveUserBiometricsServiceTestsSpec {
    func test_saveGender_savesToUserDefaults() async {
        let gender = "male"
        let sut = make_sut()
        let result = await sut.saveGender(gender)

        XCTAssertEqual(UserDefaults.standard.string(forKey: UserBiometricKeys.gender.rawValue), gender)
        XCTAssertResultVoidSuccess(result)
    }

    func test_saveBirthday_savesToUserDefaults() async {
        let birthday = Date()
        let sut = make_sut()
        let result = await sut.saveBirthday(birthday)

        let savedDate = UserDefaults.standard.object(forKey: UserBiometricKeys.birthday.rawValue) as? Date
        XCTAssertEqual(savedDate, birthday)
        XCTAssertResultVoidSuccess(result)
    }
    
    func test_saveHeight_savesToUserDefaults() async {
        let height = 175.5
        let sut = make_sut()
        let result = await sut.saveHeight(height)

        let savedHeight = UserDefaults.standard.double(forKey: UserBiometricKeys.height.rawValue)
        XCTAssertEqual(savedHeight, height)
        XCTAssertResultVoidSuccess(result)
    }
    
    func test_saveWeight_savesToUserDefaults() async {
        let weight = 72
        let sut = make_sut()
        let result = await sut.saveWeight(weight)

        let savedWeight = UserDefaults.standard.integer(forKey: UserBiometricKeys.weight.rawValue)
        XCTAssertEqual(savedWeight, weight)
        XCTAssertResultVoidSuccess(result)
    }

    func test_saveBloodType_savesToUserDefaults() async {
        let bloodType = "O+"
        let sut = make_sut()
        let result = await sut.saveBloodType(bloodType)

        let saved = UserDefaults.standard.string(forKey: UserBiometricKeys.bloodType.rawValue)
        XCTAssertEqual(saved, bloodType)
        XCTAssertResultVoidSuccess(result)
    }
}

// MARK: - Factory Helpers
extension UserDefaultsSaveUserBiometricsServiceTests {
    func make_sut() -> UserDefaultsSaveUserBiometricsService {
        clearUserDefaults()
         return UserDefaultsSaveUserBiometricsService()
    }
    
    func clearUserDefaults() {
        let keys = [
            UserBiometricKeys.gender.rawValue,
            UserBiometricKeys.birthday.rawValue,
            UserBiometricKeys.height.rawValue,
            UserBiometricKeys.weight.rawValue,
            UserBiometricKeys.bloodType.rawValue
        ]
        
        for key in keys {
            UserDefaults.standard.removeObject(forKey: key)
        }
    }
}
