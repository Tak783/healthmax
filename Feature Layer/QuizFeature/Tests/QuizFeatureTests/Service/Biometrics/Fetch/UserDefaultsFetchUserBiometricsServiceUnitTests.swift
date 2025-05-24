//
//  UserDefaultsFetchUserBiometricsServiceUnitTests.swift
//  QuizFeature
//
//  Created by Tak Mazarura on 24/05/2025.
//

import Foundation
import Testing
@testable import QuizFeature

struct UserDefaultsFetchUserBiometricsServiceUnitTests {}

// MARK: - FetchUserBiometricsServiceUnitTestsSpec
extension UserDefaultsFetchUserBiometricsServiceUnitTests: FetchUserBiometricsServiceUnitTestsSpec {
    @Test
    func test_getGender_returnsSavedValue() async {
        let (sut, defaults) = makeSUT(named: "test_getGender")
        defaults.set("Non-binary", forKey: UserBiometricKeys.gender)

        let result = await sut.getGender()

        switch result {
        case .success(let value):
            #expect(value == "Non-binary")
        case .failure(let error):
            Issue.record("getGender failed: \(error.localizedDescription)")
        }
    }

    @Test
    func test_getBirthday_returnsSavedValue() async {
        let (sut, defaults) = makeSUT(named: "test_getBirthday")
        let date = Date(timeIntervalSince1970: 987654321)
        defaults.set(date, forKey: UserBiometricKeys.birthday)

        let result = await sut.getBirthday()

        switch result {
        case .success(let value):
            #expect(value == date)
        case .failure(let error):
            Issue.record("getBirthday failed: \(error.localizedDescription)")
        }
    }

    @Test
    func test_getHeight_returnsSavedValue() async {
        let (sut, defaults) = makeSUT(named: "test_getHeight")
        defaults.set(177.8, forKey: UserBiometricKeys.height)

        let result = await sut.getHeight()

        switch result {
        case .success(let value):
            #expect(value == 177.8)
        case .failure(let error):
            Issue.record("getHeight failed: \(error.localizedDescription)")
        }
    }

    @Test
    func test_getWeight_returnsSavedValue() async {
        let (sut, defaults) = makeSUT(named: "test_getWeight")
        defaults.set(82, forKey: UserBiometricKeys.weight)

        let result = await sut.getWeight()

        switch result {
        case .success(let value):
            #expect(value == 82)
        case .failure(let error):
            Issue.record("getWeight failed: \(error.localizedDescription)")
        }
    }
}

// MARK: - Helpers
extension UserDefaultsFetchUserBiometricsServiceUnitTests {
    func makeSUT(named suiteName: String) -> (
        sut: UserDefaultsFetchUserBiometricsService,
        defaults: UserDefaults
    ) {
        let defaults = UserDefaults(suiteName: suiteName)!
        defaults.removePersistentDomain(forName: suiteName)
        let sut = UserDefaultsFetchUserBiometricsService(defaults: defaults)
        return (sut, defaults)
    }
}
