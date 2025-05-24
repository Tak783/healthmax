//
//  HealthKitService.swift
//  HealthMax
//
//  Created by Tak Mazarura on 24/05/2025.
//

import CoreFoundational
import Foundation
import HealthKit

final class HealthKitHealthDataService {
    private let healthStore = HKHealthStore()
}

// MARK: - HealthDataServiceable
extension HealthKitHealthDataService: HealthDataServiceable {
    func userAuthorized() -> Bool {
        let typesToCheck: [HKObjectType] = [
            HKObjectType.quantityType(forIdentifier: .stepCount),
            HKObjectType.quantityType(forIdentifier: .bodyMass),
            HKObjectType.quantityType(forIdentifier: .heartRate),
            HKObjectType.quantityType(forIdentifier: .bloodGlucose),
            HKObjectType.categoryType(forIdentifier: .sleepAnalysis),
            HKObjectType.quantityType(forIdentifier: .activeEnergyBurned),
            HKObjectType.quantityType(forIdentifier: .bodyTemperature),
            HKObjectType.quantityType(forIdentifier: .bloodPressureSystolic),
            HKObjectType.quantityType(forIdentifier: .bloodPressureDiastolic)
        ].compactMap { $0 }

        for type in typesToCheck {
            let status = healthStore.authorizationStatus(for: type)
            if status != .sharingAuthorized {
                return false
            }
        }

        return true
    }
    
    func fetchAllMetrics(for date: Date = .now) async -> [HealthMetric] {
        await withTaskGroup(of: HealthMetric?.self) { group in
            var results: [HealthMetric?] = []

            group.addTask {
                if let value = try? await self.fetchWeight().map({ "\($0) kg" }) {
                    return HealthMetric(type: .weight, value: value)
                }
                return nil
            }

            group.addTask {
                if let steps = try? await self.fetchSteps(for: date) {
                    return HealthMetric(type: .steps, value: "\(Int(steps)) steps")
                }
                return nil
            }

            group.addTask {
                if
                    let heartRates = try? await self.fetchHeartRateSamples(for: date),
                    let avg = heartRates.average
                {
                    return HealthMetric(type: .heartRate, value: "\(Int(avg)) bloodPressurem")
                }
                return nil
            }

            group.addTask {
                if let glucose = try? await self.fetchBloodGlucose() {
                    return HealthMetric(type: .bloodGlucose, value: "\(Int(glucose)) mg/dL")
                }
                return nil
            }

            group.addTask {
                if let cal = try? await self.fetchCalories(for: date) {
                    return HealthMetric(type: .calories, value: "\(Int(cal)) kcal")
                }
                return nil
            }

            group.addTask {
                if let temp = try? await self.fetchBodyTemperature() {
                    return HealthMetric(
                        type: .bodyTemperature,
                        value: "\(String(format: "%.1f", temp)) °C"
                    )
                }
                return nil
            }

            group.addTask {
                if
                    let bloodPressure = try? await self.fetchBloodPressure(),
                    let systolicPressure = bloodPressure.systolic,
                    let diastolicPressure = bloodPressure.diastolic
                {
                    return HealthMetric(
                        type: .bloodPressure,
                        value: "\(Int(systolicPressure))/\(Int(diastolicPressure)) mmHg"
                    )
                }
                return nil
            }

            for await metric in group {
                results.append(metric)
            }

            return results.compactMap { $0 }
        }
    }
    
    func fetchWeight() async throws -> Double? {
        try await fetchMostRecent(.bodyMass, unit: .gramUnit(with: .kilo))
    }

    func fetchSteps(for date: Date = .now) async throws -> Double {
        try await fetchSum(.stepCount, unit: .count(), date: date)
    }

    func fetchHeartRateSamples(for date: Date = .now) async throws -> [Double] {
        try await fetchAllSamples(.heartRate, unit: HKUnit.count().unitDivided(by: .minute()), date: date)
    }

    func fetchBloodGlucose() async throws -> Double? {
        try await fetchMostRecent(.bloodGlucose, unit: HKUnit(from: "mg/dL"))
    }

    func fetchCalories(for date: Date = .now) async throws -> Double {
        try await fetchSum(.activeEnergyBurned, unit: .kilocalorie(), date: date)
    }

    func fetchBodyTemperature() async throws -> Double? {
        try await fetchMostRecent(.bodyTemperature, unit: .degreeCelsius())
    }

    func fetchBloodPressure() async throws -> (systolic: Double?, diastolic: Double?) {
        let systolic = try await fetchMostRecent(.bloodPressureSystolic, unit: HKUnit.millimeterOfMercury())
        let diastolic = try await fetchMostRecent(.bloodPressureDiastolic, unit: HKUnit.millimeterOfMercury())
        return (systolic, diastolic)
    }
}

// MARK: - Fetch Helpers
extension HealthKitHealthDataService {
    private func fetchSum(
        _ identifier: HKQuantityTypeIdentifier,
        unit: HKUnit,
        date: Date
    ) async throws -> Double {
        let type = try resolveQuantityType(identifier)
        let predicate = HKQuery.predicateForSamples(
            withStart: date.startOfDay,
            end: date.endOfDay
        )
        return try await executeStatisticsQuery(
            type: type,
            predicate: predicate,
            unit: unit
        )
    }
    
    private func fetchMostRecent(
        _ identifier: HKQuantityTypeIdentifier,
        unit: HKUnit
    ) async throws -> Double? {
        let type = try resolveQuantityType(identifier)
        let sort = NSSortDescriptor(
            key: HKSampleSortIdentifierEndDate,
            ascending: false
        )
        return try await executeMostRecentSampleQuery(
            type: type,
            sortDescriptors: [sort],
            unit: unit
        )
    }
    
    private func fetchAllSamples(
        _ identifier: HKQuantityTypeIdentifier,
        unit: HKUnit,
        date: Date
    ) async throws -> [Double] {
        let type = try resolveQuantityType(identifier)
        let predicate = HKQuery.predicateForSamples(
            withStart: date.startOfDay,
            end: date.endOfDay
        )
        return try await executeAllSamplesQuery(
            type: type,
            predicate: predicate,
            unit: unit
        )
    }
}

// MARK: - Core Reusable Queries
extension HealthKitHealthDataService {
    private func resolveQuantityType(
        _ identifier: HKQuantityTypeIdentifier
    ) throws -> HKQuantityType {
        guard let type = HKQuantityType.quantityType(forIdentifier: identifier) else {
            throw HealthKitError.noData
        }
        return type
    }

    private func executeStatisticsQuery(
        type: HKQuantityType,
        predicate: NSPredicate,
        unit: HKUnit
    ) async throws -> Double {
        return try await withCheckedThrowingContinuation { continuation in
            let query = HKStatisticsQuery(
                quantityType: type,
                quantitySamplePredicate: predicate,
                options: .cumulativeSum
            ) { _, result, error in
                if let quantity = result?.sumQuantity() {
                    continuation.resume(returning: quantity.doubleValue(for: unit))
                } else {
                    continuation.resume(throwing: error ?? HealthKitError.noData)
                }
            }
            healthStore.execute(query)
        }
    }

    private func executeMostRecentSampleQuery(
        type: HKQuantityType,
        sortDescriptors: [NSSortDescriptor],
        unit: HKUnit
    ) async throws -> Double? {
        return try await withCheckedThrowingContinuation { continuation in
            let query = HKSampleQuery(
                sampleType: type,
                predicate: nil,
                limit: 1,
                sortDescriptors: sortDescriptors
            ) { _, results, error in
                if let sample = results?.first as? HKQuantitySample {
                    continuation.resume(returning: sample.quantity.doubleValue(for: unit))
                } else {
                    continuation.resume(returning: nil)
                }
            }
            healthStore.execute(query)
        }
    }

    private func executeAllSamplesQuery(
        type: HKQuantityType,
        predicate: NSPredicate,
        unit: HKUnit
    ) async throws -> [Double] {
        return try await withCheckedThrowingContinuation { continuation in
            let query = HKSampleQuery(
                sampleType: type,
                predicate: predicate,
                limit: HKObjectQueryNoLimit,
                sortDescriptors: nil
            ) { _, results, error in
                if let samples = results as? [HKQuantitySample] {
                    continuation.resume(returning: samples.map {
                        $0.quantity.doubleValue(for: unit)
                    })
                } else {
                    continuation.resume(returning: [])
                }
            }
            healthStore.execute(query)
        }
    }
}
