//
//  UserDefaultsFetchUserBiometricsService.swift
//  QuizFeature
//
//  Created on 24/05/2025.
//

import CoreFoundational
import Foundation
import QuizFeature

final class UserDefaultsFetchUserBiometricsService {
    enum BiometricFetchError: Error {
        case allValuesMissing
        case missingValue(forKey: String)
        case typeMismatch(expected: String, actual: Any.Type, key: String)
    }
}

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

    func fetchAllMetrics() async -> Result<[HealthMetric], Error> {
        async let genderResult = getGender()
        async let birthdayResult = getBirthday()
        async let heightResult = getHeight()
        async let weightResult = getWeight()

        let results = await (
            genderResult,
            birthdayResult,
            heightResult,
            weightResult
        )

        var metrics: [HealthMetric] = []

        if case let .success(value) = results.0, let gender = value {
            metrics.append(HealthMetric(type: .gender, value: gender.capitalized))
        }

        if case let .success(value) = results.1, let birthday = value {
            let formatted = DateFormatter.readableDayOnlyDateFormatter.string(from: birthday)
            metrics.append(HealthMetric(type: .birthday, value: formatted))
        }

        if case let .success(value) = results.2, let height = value {
            let (feet, inches) = Double.toFeet(height)
            metrics.append(HealthMetric(type: .height, value: "\(feet)'\(inches) ft"))
        }

        if case let .success(value) = results.3, let weight = value {
            metrics.append(HealthMetric(type: .weight, value: "\(weight) kg"))
        }

        if metrics.isEmpty {
            efficientPrint("⛔️ Failed to fetch stored metrics")
            return .failure(BiometricFetchError.allValuesMissing)
        } else {
            efficientPrint("✅ Successfully fetched: \(metrics.count) stored metrics")
            return .success(metrics)
        }
    }
}

// MARK: - Helpers
extension UserDefaultsFetchUserBiometricsService {
    private func fetch<T>(forKey key: String) async -> Result<T, Error> {
        guard let rawValue = UserDefaults.standard.object(forKey: key) else {
            return .failure(BiometricFetchError.missingValue(forKey: key))
        }

        guard let value = rawValue as? T else {
            return .failure(BiometricFetchError.typeMismatch(
                expected: "\(T.self)",
                actual: type(of: rawValue),
                key: key
            ))
        }

        return .success(value)
    }
}
