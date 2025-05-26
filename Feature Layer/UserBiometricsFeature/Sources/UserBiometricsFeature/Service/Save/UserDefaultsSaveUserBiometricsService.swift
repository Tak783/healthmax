//
//  UserDefaultsUserBiometricsService.swift
//  QuizFeature
//
//  Created on 24/05/2025.
//

import CoreHealthMaxModels
import Foundation

public struct UserDefaultsSaveUserBiometricsService {
    public init() {}
}

// MARK: - SaveUserBiometricsServiceable
extension UserDefaultsSaveUserBiometricsService: SaveUserBiometricsServiceable {
    public func saveGender(_ gender: String) async -> Result<Void, Error> {
        await save(value: gender, forKey: UserBiometricKeys.gender.rawValue)
    }
    
    public func saveBirthday(_ date: Date) async -> Result<Void, Error> {
        await save(value: date, forKey: UserBiometricKeys.birthday.rawValue)
    }
    
    public func saveHeight(_ height: Double) async -> Result<Void, Error> {
        await save(value: height, forKey: UserBiometricKeys.height.rawValue)
    }
    
    public func saveWeight(_ weight: Int) async -> Result<Void, Error> {
        await save(value: weight, forKey: UserBiometricKeys.weight.rawValue)
    }
    
    public func saveBloodType(_ bloodType: String) async -> Result<Void, Error> {
        await save(value: bloodType, forKey: UserBiometricKeys.bloodType.rawValue)
    }
}

// MARK: - Helpers
extension UserDefaultsSaveUserBiometricsService {
    // TODO: - Move to a new swift package
    private func save<T>(value: T, forKey key: String) async -> Result<Void, Error> {
        UserDefaults.standard.set(value, forKey: key)
        return .success(())
    }
}
