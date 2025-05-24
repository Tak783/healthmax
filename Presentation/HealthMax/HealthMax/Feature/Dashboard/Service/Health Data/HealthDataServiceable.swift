//
//  HealthDataServiceable.swift
//  HealthMax
//
//  Created by Tak Mazarura on 24/05/2025.
//

import Foundation

protocol HealthDataServiceable {
    func userAuthorized() -> Bool
    func fetchAllMetrics(for date: Date) async -> [HealthMetric]
    
    func fetchWeight() async throws -> Double?
    func fetchSteps(for date: Date) async throws -> Double
    func fetchHeartRateSamples(for date: Date) async throws -> [Double]
    func fetchBloodGlucose() async throws -> Double?
    func fetchCalories(for date: Date) async throws -> Double
    func fetchBodyTemperature() async throws -> Double?
    func fetchBloodPressure() async throws -> (systolic: Double?, diastolic: Double?)
}
