//
//  UserDefaultsSaveUserBiometricsServiceUnitTests.swift
//  QuizFeature
//
//  Created by Tak Mazarura on 24/05/2025.
//

import XCTest
import Testing
@testable import QuizFeature

struct UserDefaultsSaveUserBiometricsServiceUnitTests {}

// MARK: - SaveUserBiometricsServiceUnitTestsSpec
extension UserDefaultsSaveUserBiometricsServiceUnitTests: SaveUserBiometricsServiceUnitTestsSpec {
    @Test
    func test_saveGender_savesSuccessfully() async {
        let (service, defaults) = makeSUT(named: "test_saveGender")
        
        let result = await service.saveGender("Male")

        switch result {
        case .success:
            let saved = defaults.string(forKey: UserBiometricKeys.gender)
            #expect(saved == "Male")
        case .failure(let error):
            Issue.record("saveGender failed: \(error.localizedDescription)")
        }
    }

    @Test
    func test_saveBirthday_savesSuccessfully() async {
        let (sut, defaults) = makeSUT(named: "test_saveBirthday")

        let date = Date(timeIntervalSince1970: 123456789)
        let result = await sut.saveBirthday(date)

        switch result {
        case .success:
            let saved = defaults.object(forKey: UserBiometricKeys.birthday) as? Date
            #expect(saved == date)
        case .failure(let error):
            Issue.record("saveBirthday failed: \(error.localizedDescription)")
        }
    }

    @Test
    func test_saveHeight_savesSuccessfully() async {
        let (sut, defaults) = makeSUT(named: "test_saveHeight")

        let result = await sut.saveHeight(180.0)

        switch result {
        case .success:
            let saved = defaults.double(forKey: UserBiometricKeys.height)
            #expect(saved == 180.0)
        case .failure(let error):
            Issue.record("saveHeight failed: \(error.localizedDescription)")
        }
    }

    @Test
    func test_saveWeight_savesSuccessfully() async {
        let (sut, defaults) = makeSUT(named: "test_saveWeight")

        let result = await sut.saveWeight(75)

        switch result {
        case .success:
            let saved = defaults.integer(forKey: UserBiometricKeys.weight)
            #expect(saved == 75)
        case .failure(let error):
            Issue.record("saveWeight failed: \(error.localizedDescription)")
        }
    }
}

// MARK: - Helpers
extension UserDefaultsSaveUserBiometricsServiceUnitTests {
    func makeSUT(named suiteName: String) -> (
        sut: UserDefaultsSaveUserBiometricsService,
        defaults: UserDefaults
    ) {
        let defaults = UserDefaults(suiteName: suiteName)!
        defaults.removePersistentDomain(forName: suiteName)
        let sut = UserDefaultsSaveUserBiometricsService(defaults: defaults)
        return (sut, defaults)
    }
}
