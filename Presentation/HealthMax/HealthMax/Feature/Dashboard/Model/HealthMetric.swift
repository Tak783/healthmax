//
//  HealthMetric.swift
//  HealthMax
//
//  Created on 24/05/2025.
//

import CorePresentation

struct HealthMetric: Codable, Hashable, Sendable {
    let type: HealthMetricType
    let title: String
    let value: String
    let image: LocalImage

    init(type: HealthMetricType, value: String) {
        self.type = type
        self.title = type.displayName
        self.value = value
        self.image = type.icon
    }
}
