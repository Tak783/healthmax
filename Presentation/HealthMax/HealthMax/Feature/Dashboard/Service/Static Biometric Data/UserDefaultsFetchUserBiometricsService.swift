//
//  UserDefaultsFetchUserBiometricsService.swift
//  QuizFeature
//
//  Created by Tak Mazarura on 24/05/2025.
//

import Foundation
import QuizFeature

final class UserDefaultsFetchUserBiometricsService {}

// MARK: - FetchUserBiometricsServiceable
extension UserDefaultsFetchUserBiometricsService: FetchUserBiometricsServiceable {
    func getGender() async -> Result<String?, Error> {
        await fetch(forKey: UserBiometricKeys.gender.rawValue)
    }
    
    func getBirthday() async -> Result<Date?, Error> {
        await fetch(forKey: UserBiometricKeys.birthday.rawValue)
    }
    
    func getHeight() async -> Result<Double?, Error> {
        await fetch(forKey: UserBiometricKeys.height.rawValue)
    }
    
    func getWeight() async -> Result<Int?, Error> {
        await fetch(forKey: UserBiometricKeys.weight.rawValue)
    }
}

// MARK: - Helpers
extension UserDefaultsFetchUserBiometricsService {
    private func fetch<T>(forKey key: String) async -> Result<T?, Error> {
        let value = UserDefaults.standard.object(forKey: key) as? T
        return .success(value)
    }
}
