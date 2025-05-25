//
//  FetchUserBiometricsServiceable.swift
//  QuizFeature
//
//  Created on 24/05/2025.
//

import Foundation

typealias MetricsFetchResult =  Result<[HealthMetric], any Error>

protocol FetchUserBiometricsServiceable {
    func getGender() async -> Result<String?, Error>
    func getBirthday() async -> Result<Date?, Error>
    func getHeight() async -> Result<Double?, Error>
    func getWeight() async -> Result<Int?, Error>
    
    func fetchAllMetrics() async -> MetricsFetchResult
}
