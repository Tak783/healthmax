//
//  HealthImprovement.swift
//  CoreHealthMaxModels
//
//  Created on 02/06/2025.
//

import Foundation

public struct HealthImprovementRecommendation: Sendable, Identifiable, Hashable {
    public let id: String
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
        self.id = UUID().uuidString
        self.metricType = metricType
        self.currentValue = currentValue
        self.targetValue = targetValue
        self.targetRange = targetRange
        self.targetTrend = targetTrend
        self.summary = summary
        self.actions = actions
    }
}

// MARK: - Codable
extension HealthImprovementRecommendation: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = UUID().uuidString // always generate new for now until we are persisting ids from server
        self.metricType = try container.decode(HealthMetricType.self, forKey: .metricType)
        self.currentValue = try container.decode(Double.self, forKey: .currentValue)
        self.targetValue = try container.decodeIfPresent(Double.self, forKey: .targetValue)

        if let range = try container.decodeIfPresent([Double].self, forKey: .targetRange),
           range.count == 2 {
            self.targetRange = range[0]...range[1]
        } else {
            self.targetRange = nil
        }

        self.targetTrend = try container.decode(TargetTrend.self, forKey: .targetTrend)
        self.summary = try container.decode(String.self, forKey: .summary)
        self.actions = try container.decode([String].self, forKey: .actions)
    }

    private enum CodingKeys: String, CodingKey {
        case metricType
        case currentValue
        case targetValue
        case targetRange
        case targetTrend
        case summary
        case actions
    }
}
