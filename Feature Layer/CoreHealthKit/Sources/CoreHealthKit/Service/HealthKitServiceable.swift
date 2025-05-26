//
//  HealthKitServiceable.swift
//  CoreHealthKit
//
//  Created on 26/05/2025.
//

import CoreFoundational
import HealthKit

public protocol HealthKitServiceable {
    var healthStore: HKHealthStore { get }
    
    func fetchMostRecent(
        _ identifier: HKQuantityTypeIdentifier,
        unit: HKUnit
    ) async throws -> Double?
    
    func fetchSum(
        _ identifier: HKQuantityTypeIdentifier,
        unit: HKUnit,
        date: Date
    ) async throws -> Double
    
    func fetchAllSamples(
        _ identifier: HKQuantityTypeIdentifier,
        unit: HKUnit,
        date: Date
    ) async throws -> [Double]
}

// MARK: - Default Implementations
extension HealthKitServiceable {
    public func fetchMostRecent(
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
    
    public func fetchSum(
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
    
    public func fetchAllSamples(
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

// MARK: - Helpers
extension HealthKitServiceable {
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
