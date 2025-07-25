//
//  HealthMetricPresentationModel.swift
//  HealthMax
//
//  Created on 25/05/2025.
//

import CoreSharedModels
import CoreHealthMaxModels

public struct HealthMetricPresentationModel: Hashable, Sendable {
    public let title: String
    public let value: String
    public let icon: LocalImage

    public init(metric: HealthMetric) {
        self.title = metric.type.displayName
        self.value = metric.value.defaultStringValue + String.space + (metric.unit?.unitString ?? String.empty)
        self.icon = metric.type.icon
    }
}
