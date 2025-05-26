//
//  UserDefaultsFetchUserBiometricsServiceTests.swift
//  UserBiometricsFeature
//
//  Created on 26/05/2025.
//

import XCTest
import CoreHealthMaxModels
@testable import UserBiometricsFeature

final class UserDefaultsFetchUserBiometricsServiceTests: XCTestCase {}

// MARK: - FetchUserBiometricsServiceTestsSpec
extension UserDefaultsFetchUserBiometricsServiceTests: FetchUserBiometricsServiceTestsSpec {
    func test_getGender_returnsStoredValue() async {
        let expected = "female"
        let saveService = makeStubSaveService()
        
        let sut = make_sut()
        
        await _ = saveService.saveGender(expected)
        
        let result = await sut.getGender()
        
        XCTAssertResultSuccess(result, equals: expected)
    }
    
    func test_getBirthday_returnsStoredValue() async {
        let expected = Date()
        let saveService = makeStubSaveService()
        
        let sut = make_sut()
        
        await _ = saveService.saveBirthday(expected)
        
        let result = await sut.getBirthday()
        
        XCTAssertResultSuccess(result, equals: expected)
    }
    
    func test_getHeight_returnsStoredValue() async {
        let expected = 180.5
        let saveService = makeStubSaveService()
        
        let sut = make_sut()
        
        await _ = saveService.saveHeight(expected)
        
        let result = await sut.getHeight()
        
        XCTAssertResultSuccess(result, equals: expected)
    }
    
    func test_getWeight_returnsStoredValue() async {
        let expected = 78
        let saveService = makeStubSaveService()
        
        let sut = make_sut()
        
        await _ = saveService.saveWeight(expected)
        
        let result = await sut.getWeight()
        
        XCTAssertResultSuccess(result, equals: expected)
    }
    
    func test_getBloodType_returnsStoredValue() async {
        let expected = "A+"
        let saveService = makeStubSaveService()
        
        let sut = make_sut()
        
        await _ = saveService.saveBloodType(expected)
    
        let result = await sut.getBloodType()
        
        XCTAssertResultSuccess(result, equals: expected)
    }
    
    func test_fetchAllMetrics_returnsAllNonNilMetrics() async {
        let saveService = makeStubSaveService()
        
        let sut = make_sut()
        
        await _ = saveService.saveGender("male")
        await _ = saveService.saveBirthday(Date())
        await _ = saveService.saveHeight(170.0)
        await _ = saveService.saveWeight(70)
        await _ = saveService.saveBloodType("O+")
        
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

// MARK: - Factory Helpers
extension UserDefaultsFetchUserBiometricsServiceTests {
    func make_sut() -> UserDefaultsFetchUserBiometricsService {
        clearUserDefaults()
        return UserDefaultsFetchUserBiometricsService()
    }
    
    func makeStubSaveService() -> StubUserDefaultsSaveUserBiometricsService {
        clearUserDefaults()
        return StubUserDefaultsSaveUserBiometricsService()
    }
}

// MARK: - Helpers
extension UserDefaultsFetchUserBiometricsServiceTests {
    private func clearUserDefaults() {
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
