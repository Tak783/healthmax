//
//  HealthDataServiceable.swift
//  HealthMax
//
//  Created on 24/05/2025.
//

import Foundation

typealias MetricFetchResult =  Result<HealthMetric, any Error>

protocol HealthDataServiceable {
    func fetchAllMetrics(for date: Date) async -> MetricsFetchResult
    
    func fetchWeight() async -> MetricFetchResult
    func fetchSteps(for date: Date) async -> MetricFetchResult
    func fetchHeartRateSamples(for date: Date) async -> MetricFetchResult
    func fetchBloodGlucose() async -> MetricFetchResult
    func fetchCalories(for date: Date) async -> MetricFetchResult
    func fetchBodyTemperature() async -> MetricFetchResult
    func fetchBloodPressure() async -> MetricFetchResult
}
