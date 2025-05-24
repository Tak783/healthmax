//
//  FetchUserBiometricsServiceable.swift
//  QuizFeature
//
//  Created by Tak Mazarura on 24/05/2025.
//

import Foundation

protocol FetchUserBiometricsServiceable {
    func getGender() async -> Result<String?, Error>
    func getBirthday() async -> Result<Date?, Error>
    func getHeight() async -> Result<Double?, Error>
    func getWeight() async -> Result<Int?, Error>
    
    func fetchAllMetrics() async -> Result<[HealthMetric], Error>
}
