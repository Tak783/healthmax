//
//  HealthMetric.swift
//  HealthMax
//
//  Created on 24/05/2025.
//

import CoreSharedModels
import Foundation
import HealthKit

public struct HealthMetric: Hashable, Sendable {
    public let id: String
    public let type: HealthMetricType
    public let value: HealthMetricValue
    public let unit: HKUnit?

    public init(
        id: String = UUID().uuidString,
        type: HealthMetricType,
        value: HealthMetricValue,
        unit: HKUnit? = nil
    ) {
        self.id = id
        self.type = type
        self.value = value
        self.unit = unit
    }
}
