//
//  HealthKitService.swift
//  HealthMax
//
//  Created by Tak Mazarura on 24/05/2025.
//

import CoreFoundational
import Foundation
import HealthKit

struct HealthKitHealthDataService {
    enum HealthKitFetchError: Error {
        case allValuesMissing
        case noData
    }
    
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
    
    func fetchWeight() async -> Result<HealthMetric, Error> {
        do {
            guard let value = try await fetchMostRecent(.bodyMass, unit: .gramUnit(with: .kilo)) else {
                return .failure(HealthKitFetchError.noData)
            }
            let metric = HealthMetric(type: .weight, value: "\(value) kg")
            return .success(metric)
        } catch {
            return .failure(error)
        }
    }

    func fetchSteps(for date: Date = .now) async -> Result<HealthMetric, Error> {
        do {
            let steps = try await fetchSum(.stepCount, unit: .count(), date: date)
            let metric = HealthMetric(type: .steps, value: "\(Int(steps)) steps")
            return .success(metric)
        } catch {
            return .failure(error)
        }
    }

    func fetchHeartRateSamples(for date: Date = .now) async -> Result<HealthMetric, Error> {
        do {
            let samples = try await fetchAllSamples(
                .heartRate,
                unit: HKUnit.count().unitDivided(by: .minute()),
                date: date
            )
            guard let avg = samples.average else {
                return .failure(HealthKitFetchError.noData)
            }
            let metric = HealthMetric(type: .heartRate, value: "\(Int(avg)) bpm")
            return .success(metric)
        } catch {
            return .failure(error)
        }
    }

    func fetchBloodGlucose() async -> Result<HealthMetric, Error> {
        do {
            guard let value = try await fetchMostRecent(.bloodGlucose, unit: HKUnit(from: "mg/dL")) else {
                return .failure(HealthKitFetchError.noData)
            }
            let metric = HealthMetric(type: .bloodGlucose, value: "\(Int(value)) mg/dL")
            return .success(metric)
        } catch {
            return .failure(error)
        }
    }

    func fetchCalories(for date: Date = .now) async -> Result<HealthMetric, Error> {
        do {
            let cals = try await fetchSum(.activeEnergyBurned, unit: .kilocalorie(), date: date)
            let metric = HealthMetric(type: .calories, value: "\(Int(cals)) kcal")
            return .success(metric)
        } catch {
            return .failure(error)
        }
    }

    func fetchBodyTemperature() async -> Result<HealthMetric, Error> {
        do {
            guard let value = try await fetchMostRecent(.bodyTemperature, unit: .degreeCelsius()) else {
                return .failure(HealthKitFetchError.noData)
            }
            let formatted = String(format: "%.1f", value)
            let metric = HealthMetric(type: .bodyTemperature, value: "\(formatted) °C")
            return .success(metric)
        } catch {
            return .failure(error)
        }
    }

    func fetchBloodPressure() async -> Result<HealthMetric, Error> {
        do {
            guard
                let sys = try await fetchMostRecent(.bloodPressureSystolic, unit: .millimeterOfMercury()),
                let dia = try await fetchMostRecent(.bloodPressureDiastolic, unit: .millimeterOfMercury())
            else {
                return .failure(HealthKitFetchError.noData)
            }

            let metric = HealthMetric(
                type: .bloodPressure,
                value: "\(Int(sys))/\(Int(dia)) mmHg"
            )
            return .success(metric)
        } catch {
            return .failure(error)
        }
    }
    
    func fetchAllMetrics(for date: Date = .now) async -> Result<[HealthMetric], Error> {
        let tasks: [() async -> Result<HealthMetric, Error>] = [
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

        await withTaskGroup(of: Result<HealthMetric, Error>.self) { group in
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
            efficientPrint("Failed to fetch: \(errors.count) health metrics")
            return .failure(HealthKitFetchError.allValuesMissing)
        } else {
            efficientPrint("Successfully fetched: \(metrics.count) health metrics")
            efficientPrint("Failed to fetch: \(errors.count) health metrics")
            return .success(metrics)
        }
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
