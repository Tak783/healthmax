//
//  HealthImprovement.swift
//  CoreHealthMaxModels
//
//  Created on 02/06/2025.
//

import Foundation

public struct HealthImprovementRecommendation: Codable {
    public let metricType: HealthMetricType

    public let currentValue: Double
    public let targetValue: Double?
    public let targetRange: ClosedRange<Double>?
    public let targetTrend: TargetTrend

    public let summary: String
    public let actions: [String]

    public init(
        metricType: HealthMetricType,
        currentValue: Double,
        targetValue: Double? = nil,
        targetRange: ClosedRange<Double>? = nil,
        targetTrend: TargetTrend,
        summary: String,
        actions: [String]
    ) {
        self.metricType = metricType
        self.currentValue = currentValue
        self.targetValue = targetValue
        self.targetRange = targetRange
        self.targetTrend = targetTrend
        self.summary = summary
        self.actions = actions
    }
}
