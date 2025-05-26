//
//  UserDefaultsFetchUserBiometricsService.swift
//  QuizFeature
//
//  Created on 24/05/2025.
//

import CoreHealthMaxModels
import CoreFoundational
import Foundation
import HealthKit

public final class UserDefaultsFetchUserBiometricsService {
    enum BiometricFetchError: Error {
        case allValuesMissing
        case missingValue(forKey: String)
        case typeMismatch(expected: String, actual: Any.Type, key: String)
    }
    
    public init() {}
}

// MARK: - FetchUserBiometricsServiceable
extension UserDefaultsFetchUserBiometricsService: FetchUserBiometricsServiceable {
    public func getGender() async -> Result<String?, Error> {
        await fetch(forKey: UserBiometricKeys.gender.rawValue)
    }
    
    public func getBirthday() async -> Result<Date?, Error> {
        await fetch(forKey: UserBiometricKeys.birthday.rawValue)
    }
    
    public func getHeight() async -> Result<Double?, Error> {
        await fetch(forKey: UserBiometricKeys.height.rawValue)
    }
    
    public func getWeight() async -> Result<Int?, Error> {
        await fetch(forKey: UserBiometricKeys.weight.rawValue)
    }
    
    public func getBloodType() async -> Result<String?, Error> {
        await fetch(forKey: UserBiometricKeys.bloodType.rawValue)
    }

    public func fetchAllMetrics() async -> Result<[HealthMetric], Error> {
        async let genderResult = getGender()
        async let birthdayResult = getBirthday()
        async let heightResult = getHeight()
        async let weightResult = getWeight()
        async let bloodTypeResult = getBloodType()

        let results = await (
            genderResult,
            birthdayResult,
            heightResult,
            weightResult,
            bloodTypeResult
        )

        var metrics: [HealthMetric] = []

        if case let .success(value) = results.0, let gender = value {
            metrics.append(HealthMetric(type: .gender, value: HealthMetricValue.string(gender) ))
        }

        if case let .success(value) = results.1, let birthday = value {
            metrics.append(HealthMetric(type: .birthday, value: HealthMetricValue.date(birthday)))
        }

        if case let .success(value) = results.2, let height = value {
            metrics.append(HealthMetric(type: .height, value: HealthMetricValue.double(height), unit: .foot()))
        }

        if case let .success(value) = results.3, let weight = value {
            metrics.append(HealthMetric(type: .weight, value: HealthMetricValue.int(weight), unit: .gramUnit(with: .kilo)))
        }
        
        if case let .success(value) = results.4, let bloodType = value {
            metrics.append(HealthMetric(type: .bloodType, value: HealthMetricValue.string(bloodType)))
        }

        if metrics.isEmpty {
            safePrint("⛔️ Failed to fetch stored metrics")
            return .failure(BiometricFetchError.allValuesMissing)
        } else {
            safePrint("✅ Successfully fetched: \(metrics.count) stored metrics")
            return .success(metrics)
        }
    }
}

// MARK: - Helpers
extension UserDefaultsFetchUserBiometricsService {
    // TODO: - Move to a new swift package
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
