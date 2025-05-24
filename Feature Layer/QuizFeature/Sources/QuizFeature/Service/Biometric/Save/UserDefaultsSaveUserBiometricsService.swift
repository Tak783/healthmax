//
//  UserDefaultsUserBiometricsService.swift
//  QuizFeature
//
//  Created by Tak Mazarura on 24/05/2025.
//

import Foundation

final class UserDefaultsSaveUserBiometricsService {    
    private let defaults: UserDefaults
    
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }
}

// MARK: - SaveUserBiometricsServiceable
extension UserDefaultsSaveUserBiometricsService: SaveUserBiometricsServiceable {
    func saveGender(_ gender: String) async -> Result<Void, Error> {
        await save(value: gender, forKey: UserBiometricKeys.gender)
    }
    
    func saveBirthday(_ date: Date) async -> Result<Void, Error> {
        await save(value: date, forKey: UserBiometricKeys.birthday)
    }
    
    func saveHeight(_ height: Double) async -> Result<Void, Error> {
        await save(value: height, forKey: UserBiometricKeys.height)
    }
    
    func saveWeight(_ weight: Int) async -> Result<Void, Error> {
        await save(value: weight, forKey: UserBiometricKeys.weight)
    }
}

// MARK: - Helpers
extension UserDefaultsSaveUserBiometricsService {
    private func save<T>(value: T, forKey key: String) async -> Result<Void, Error> {
        defaults.set(value, forKey: key)
        return .success(())
    }
}
