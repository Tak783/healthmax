//
//  UserDefaultsUserBiometricsService.swift
//  QuizFeature
//
//  Created on 24/05/2025.
//

import Foundation

final class UserDefaultsSaveUserBiometricsService {}

// MARK: - SaveUserBiometricsServiceable
extension UserDefaultsSaveUserBiometricsService: SaveUserBiometricsServiceable {
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
}

// MARK: - Helpers
extension UserDefaultsSaveUserBiometricsService {
    private func save<T>(value: T, forKey key: String) async -> Result<Void, Error> {
        UserDefaults.standard.set(value, forKey: key)
        return .success(())
    }
}
