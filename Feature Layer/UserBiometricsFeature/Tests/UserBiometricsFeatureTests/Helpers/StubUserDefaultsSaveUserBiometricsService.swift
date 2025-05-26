//
//  StubUserDefaultsSaveUserBiometricsService.swift
//  UserBiometricsFeature
//
//  Created by Tak Mazarura on 26/05/2025.
//

import Foundation
import CoreHealthMaxModels
@testable import UserBiometricsFeature

struct StubUserDefaultsSaveUserBiometricsService {
    init() {}
}

// MARK: - SaveUserBiometricsServiceable
extension StubUserDefaultsSaveUserBiometricsService: SaveUserBiometricsServiceable {
    func saveGender(_ gender: String) async -> Result<Void, Error> {
        await save(value: gender, forKey: UserBiometricKeys.gender.rawValue)
    }
    
    func saveBirthday(_ date: Date) async -> Result<Void, Error> {
        await save(value: date, forKey: UserBiometricKeys.birthday.rawValue)
    }
    
    func saveHeight(_ height: Double) async -> Result<Void, Error> {
        await save(value: height, forKey: UserBiometricKeys.height.rawValue)
    }
    
    func saveWeight(_ weight: Int) async -> Result<Void, Error> {
        await save(value: weight, forKey: UserBiometricKeys.weight.rawValue)
    }
    
    func saveBloodType(_ bloodType: String) async -> Result<Void, Error> {
        await save(value: bloodType, forKey: UserBiometricKeys.bloodType.rawValue)
    }
}

// MARK: - Helpers
extension StubUserDefaultsSaveUserBiometricsService {
    private func save<T>(value: T, forKey key: String) async -> Result<Void, Error> {
        UserDefaults.standard.set(value, forKey: key)
        return .success(())
    }
}
