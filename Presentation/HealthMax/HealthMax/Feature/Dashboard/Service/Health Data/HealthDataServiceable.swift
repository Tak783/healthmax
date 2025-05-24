//
//  HealthDataServiceable.swift
//  HealthMax
//
//  Created by Tak Mazarura on 24/05/2025.
//

import Foundation

protocol HealthDataServiceable {
    func fetchAllMetrics(for date: Date) async -> Result<[HealthMetric], Error> 
    
    func fetchWeight() async -> Result<HealthMetric, Error>
    func fetchSteps(for date: Date) async -> Result<HealthMetric, Error>
    func fetchHeartRateSamples(for date: Date) async -> Result<HealthMetric, Error>
    func fetchBloodGlucose() async -> Result<HealthMetric, Error>
    func fetchCalories(for date: Date) async -> Result<HealthMetric, Error>
    func fetchBodyTemperature() async -> Result<HealthMetric, Error>
    func fetchBloodPressure() async -> Result<HealthMetric, Error>
}
