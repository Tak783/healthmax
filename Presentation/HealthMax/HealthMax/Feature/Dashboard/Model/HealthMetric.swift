//
//  HealthMetric.swift
//  HealthMax
//
//  Created on 24/05/2025.
//

import CoreFoundational
import CorePresentation
import HealthKit

struct HealthMetric: Hashable, Sendable {
    let id: String
    let type: HealthMetricType
    let value: HealthMetricValue
    let unit: HKUnit?

    init(id: String = UUID().uuidString, type: HealthMetricType, value: HealthMetricValue, unit: HKUnit? = nil) {
        self.id = id
        self.type = type
        self.value = value
        self.unit = unit
    }
}
