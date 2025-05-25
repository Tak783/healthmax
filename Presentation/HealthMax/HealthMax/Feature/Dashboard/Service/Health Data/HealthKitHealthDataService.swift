//
//  HealthKitService.swift
//  HealthMax
//
//  Created on 24/05/2025.
//

import CoreFoundational
import Foundation
import HealthKit

public struct HealthKitHealthDataService {
    private let healthStore = HKHealthStore()
}

// MARK: - HealthDataServiceable
extension HealthKitHealthDataService: HealthDataServiceable {
    func fetchWeight(unit: HKUnit = .gramUnit(with: .kilo)) async -> MetricFetchResult {
        do {
            guard let value = try await fetchMostRecent(.bodyMass, unit: unit) else {
                return .failure(HealthKitError.noData)
            }
            let metric = HealthMetric(type: .weight, value: .double(value), unit: unit)
            return .success(metric)
        } catch {
            return .failure(error)
        }
    }

    func fetchSteps(for date: Date = .now, unit: HKUnit = .count()) async -> MetricFetchResult {
        do {
            let steps = try await fetchSum(.stepCount, unit: unit, date: date)
            let metric = HealthMetric(type: .steps, value: .int(Int(steps)), unit: unit)
            return .success(metric)
        } catch {
            return .failure(error)
        }
    }

    func fetchHeartRateSamples(
        for date: Date = .now,
        unit: HKUnit = .count().unitDivided(by: .minute())
    ) async -> MetricFetchResult {
        do {
            let samples = try await fetchAllSamples(.heartRate, unit: unit, date: date)
            guard let avg = samples.average else {
                return .failure(HealthKitError.noData)
            }
            let metric = HealthMetric(type: .heartRate, value: .double(avg), unit: unit)
            return .success(metric)
        } catch {
            return .failure(error)
        }
    }

    func fetchBloodGlucose(unit: HKUnit = HKUnit(from: "mg/dL")) async -> MetricFetchResult {
        do {
            guard let value = try await fetchMostRecent(.bloodGlucose, unit: unit) else {
                return .failure(HealthKitError.noData)
            }
            let metric = HealthMetric(type: .bloodGlucose, value: .int(Int(value)), unit: unit)
            return .success(metric)
        } catch {
            return .failure(error)
        }
    }

    func fetchCalories(for date: Date = .now, unit: HKUnit = .kilocalorie()) async -> MetricFetchResult {
        do {
            let cals = try await fetchSum(.activeEnergyBurned, unit: unit, date: date)
            let metric = HealthMetric(type: .calories, value: .int(Int(cals)), unit: unit)
            return .success(metric)
        } catch {
            return .failure(error)
        }
    }

    func fetchBodyTemperature(unit: HKUnit = .degreeCelsius()) async -> MetricFetchResult {
        do {
            guard let value = try await fetchMostRecent(.bodyTemperature, unit: unit) else {
                return .failure(HealthKitError.noData)
            }
            let metric = HealthMetric(type: .bodyTemperature, value: .double(value), unit: unit)
            return .success(metric)
        } catch {
            return .failure(error)
        }
    }

    func fetchBloodPressure(unit: HKUnit = .millimeterOfMercury()) async -> MetricFetchResult {
        do {
            guard
                let systolic = try await fetchMostRecent(.bloodPressureSystolic, unit: unit),
                let diastolic = try await fetchMostRecent(.bloodPressureDiastolic, unit: unit)
            else {
                return .failure(HealthKitError.noData)
            }
            let combined = "\(Int(systolic))/\(Int(diastolic))"
            let metric = HealthMetric(type: .bloodPressure, value: .string(combined), unit: unit)
            return .success(metric)
        } catch {
            return .failure(error)
        }
    }

    func fetchAllMetrics(for date: Date = .now) async -> Result<[HealthMetric], Error> {
        let tasks: [() async -> MetricFetchResult] = [
            { await self.fetchWeight() },
            { await self.fetchSteps(for: date) },
            { await self.fetchHeartRateSamples(for: date) },
            { await self.fetchBloodGlucose() },
            { await self.fetchCalories(for: date) },
            { await self.fetchBodyTemperature() },
            { await self.fetchBloodPressure() }
        ]

        var metrics: [HealthMetric] = []
        var errors: [Error] = []

        await withTaskGroup(of: MetricFetchResult.self) { group in
            for task in tasks {
                group.addTask {
                    await task()
                }
            }

            for await result in group {
                switch result {
                case .success(let metric):
                    metrics.append(metric)
                case .failure(let error):
                    errors.append(error)
                }
            }
        }

        if metrics.isEmpty {
            safePrint("⛔️ Failed to fetch: \(errors.count) Apple Health metrics")
            return .failure(HealthKitError.allValuesMissing)
        } else {
            safePrint("✅ Successfully fetched: \(metrics.count) Apple Health metrics")
            safePrint("⛔️ Failed to fetch: \(errors.count) Apple Health metrics")
            return .success(metrics)
        }
    }
}

// MARK: - Core Reusable Queries
extension HealthKitHealthDataService {
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
