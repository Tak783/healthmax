//
//  HealthMetricPresentationModel.swift
//  HealthMax
//
//  Created by Tak Mazarura on 25/05/2025.
//

import CorePresentation

struct HealthMetricPresentationModel: Hashable, Sendable {
    let title: String
    let value: String
    let icon: LocalImage

    init(metric: HealthMetric) {
        self.title = metric.type.displayName
        self.value = metric.value.defaultStringValue + String.space + (metric.unit?.unitString ?? String.empty)
        self.icon = metric.type.icon
    }
}
