//
//  LocalHealthRecommendationService.swift
//  UserBiometricsFeature
//
//  Created by Tak Mazarura on 02/06/2025.
//

import CoreHealthMaxModels
import Foundation

@MainActor
public struct LocalHealthRecommendationService {
    public init() {}
}

// MARK: - HealthRecommendationServiceable
extension LocalHealthRecommendationService: HealthRecommendationServiceable {
    public func getRecommendations(
        for metrics: [RemoteHealthMetric]
    ) async -> Result<[HealthImprovementRecommendation], Error> {
        return .success(Self.sampleRecommendations())
    }
}

// MARK: - Factory Helpers
extension LocalHealthRecommendationService {
    public static func sampleRecommendations() -> [HealthImprovementRecommendation] {
        [
            HealthImprovementRecommendation(
                metricType: .steps,
                currentValue: 4400,
                targetValue: 8000,
                targetRange: nil,
                targetTrend: .increase,
                summary: "Your daily step count is below the recommended range.",
                actions: [
                    "Walk at least 30 minutes per day.",
                    "Add short 10-minute walks after each meal.",
                    "Use reminders to track daily activity."
                ]
            ),
            HealthImprovementRecommendation(
                metricType: .heartRate,
                currentValue: 78,
                targetValue: nil,
                targetRange: 50...65,
                targetTrend: .decrease,
                summary: "Your resting heart rate is slightly elevated.",
                actions: [
                    "Incorporate zone 2 cardio twice a week.",
                    "Reduce caffeine intake after midday.",
                    "Practice deep breathing before bed."
                ]
            )
        ]
    }
}
