//
//  HealthRecommendationServiceable.swift
//  UserBiometricsFeature
//
//  Created by Tak Mazarura on 02/06/2025.
//

import Foundation
import CoreHealthMaxModels

public protocol HealthRecommendationServiceable {
    func getRecommendations(
        for metrics: [RemoteHealthMetric]
    ) async -> Result<[HealthImprovementRecommendation], Error>
}
