//
//  HealthDataServiceable.swift
//  HealthMax
//
//  Created on 24/05/2025.
//

import Foundation
import HealthKit
import CoreHealthMaxModels

public typealias MetricFetchResult = Result<HealthMetric, any Error>
public typealias MetricsFetchResult = Result<[HealthMetric], any Error>

public protocol HealthDataServiceable: Sendable {
    func fetchAllMetrics(for date: Date) async -> MetricsFetchResult

    func fetchWeight(unit: HKUnit) async -> MetricFetchResult
    func fetchSteps(for date: Date, unit: HKUnit) async -> MetricFetchResult
    func fetchHeartRateSamples(for date: Date, unit: HKUnit) async -> MetricFetchResult
    func fetchBloodGlucose(unit: HKUnit) async -> MetricFetchResult
    func fetchCalories(for date: Date, unit: HKUnit) async -> MetricFetchResult
    func fetchBodyTemperature(unit: HKUnit) async -> MetricFetchResult
    func fetchBloodPressure(unit: HKUnit) async -> MetricFetchResult
}
