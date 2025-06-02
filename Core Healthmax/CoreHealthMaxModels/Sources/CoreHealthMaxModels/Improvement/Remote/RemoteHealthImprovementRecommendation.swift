//
//  RemoteHealthImprovementRecommendation.swift
//  CoreHealthMaxModels
//
//  Created on 02/06/2025.
//

import Foundation

public struct RemoteHealthImprovementRecommendation: Codable {
    public let metricType: HealthMetricType

    public let currentValue: Double
    public let targetValue: Double?
    public let targetRange: ClosedRange<Double>?
    public let targetTrend: TargetTrend

    public let summary: String
    public let actions: [String]

    public init(
        recommendation: HealthImprovementRecommendation
    ) {
        self.metricType = recommendation.metricType
        self.currentValue = recommendation.currentValue
        self.targetValue = recommendation.targetValue
        self.targetRange = recommendation.targetRange
        self.targetTrend = recommendation.targetTrend
        self.summary = recommendation.summary
        self.actions = recommendation.actions
    }
}

// MARK: - Helpers
extension RemoteHealthImprovementRecommendation {
    func toModel() -> HealthImprovementRecommendation {
        .init(
            metricType: self.metricType,
            currentValue: self.currentValue,
            targetValue: self.targetValue,
            targetRange: self.targetRange,
            targetTrend: self.targetTrend,
            summary: self.summary,
            actions: self.actions
        )
    }
}
