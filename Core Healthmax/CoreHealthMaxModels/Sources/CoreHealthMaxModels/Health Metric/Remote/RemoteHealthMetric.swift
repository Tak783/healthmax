//
//  RemoteHealthMetric.swift
//  CoreHealthMaxModels
//
//  Created on 02/06/2025.
//

import Foundation
import HealthKit

public struct RemoteHealthMetric: Codable, Sendable {
    public let id: String
    public let type: HealthMetricType
    public let value: HealthMetricValue
    public let unit: String?

    public init(from metric: HealthMetric) {
        self.id = metric.id
        self.type = metric.type
        self.unit = metric.unit?.unitString
        self.value = metric.value
    }
}

// MARK: - Helpers
extension RemoteHealthMetric {
    func toModel() -> HealthMetric {
        let hkUnit: HKUnit? = unit.flatMap { HKUnit(from: $0) }
        return HealthMetric(
            id: id,
            type: type,
            value: value,
            unit: hkUnit
        )
    }
}
