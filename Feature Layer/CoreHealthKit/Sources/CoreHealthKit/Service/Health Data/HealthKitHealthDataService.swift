//
//  HealthKitService.swift
//  HealthMax
//
//  Created on 24/05/2025.
//

import CoreFoundational
import CoreHealthMaxModels
import Foundation
import HealthKit

public struct HealthKitHealthDataService : Sendable{
    public private(set) var healthStore = HKHealthStore()
    
    public init(healthStore: HKHealthStore = HKHealthStore()) {
        self.healthStore = healthStore
    }
}

// MARK: - HealthKitServiceable
extension HealthKitHealthDataService: HealthKitServiceable {}

// MARK: - HealthDataServiceable
extension HealthKitHealthDataService: HealthDataServiceable {
    public func fetchWeight(unit: HKUnit = .gramUnit(with: .kilo)) async -> MetricFetchResult {
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

    public func fetchSteps(for date: Date = .now, unit: HKUnit = .count()) async -> MetricFetchResult {
        do {
            let steps = try await fetchSum(.stepCount, unit: unit, date: date)
            let metric = HealthMetric(type: .steps, value: .int(Int(steps)), unit: unit)
            return .success(metric)
        } catch {
            return .failure(error)
        }
    }

    public func fetchHeartRateSamples(
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

    public func fetchBloodGlucose(unit: HKUnit = HKUnit(from: "mg/dL")) async -> MetricFetchResult {
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

    public func fetchCalories(for date: Date = .now, unit: HKUnit = .kilocalorie()) async -> MetricFetchResult {
        do {
            let cals = try await fetchSum(.activeEnergyBurned, unit: unit, date: date)
            let metric = HealthMetric(type: .calories, value: .int(Int(cals)), unit: unit)
            return .success(metric)
        } catch {
            return .failure(error)
        }
    }

    public func fetchBodyTemperature(unit: HKUnit = .degreeCelsius()) async -> MetricFetchResult {
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

    public func fetchBloodPressure(unit: HKUnit = .millimeterOfMercury()) async -> MetricFetchResult {
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

    public func fetchAllMetrics(for date: Date = .now) async -> Result<[HealthMetric], Error> {
        let tasks: [@Sendable () async -> MetricFetchResult] = [
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
                    await task() // ✅ Fine because `task` is loop-local, not externally captured
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
