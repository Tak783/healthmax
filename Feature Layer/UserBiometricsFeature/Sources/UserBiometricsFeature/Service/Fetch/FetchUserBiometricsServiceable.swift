//
//  FetchUserBiometricsServiceable.swift
//  QuizFeature
//
//  Created on 24/05/2025.
//

import CoreHealthKit
import CoreHealthMaxModels
import Foundation

public protocol FetchUserBiometricsServiceable: Sendable {
    func getGender() async -> Result<String?, Error>
    func getBirthday() async -> Result<Date?, Error>
    func getHeight() async -> Result<Double?, Error>
    func getWeight() async -> Result<Int?, Error>
    
    func fetchAllMetrics() async -> MetricsFetchResult
}
