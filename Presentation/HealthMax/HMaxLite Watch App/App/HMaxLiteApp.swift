//
//  HMaxLiteApp.swift
//  HMaxLite Watch App
//
//  Created by Tak Mazarura on 11/06/2025.
//

import SwiftUI
import CoreHealthKit
import UserBiometricsFeature

@main
struct HMaxLite_Watch_AppApp: App {
    var body: some Scene {
        WindowGroup {
            let service = HealthKitHealthDataService()
            let viewModel = SimpleRecommendationsViewModel(healthService: service)
            RecommendationsCarouselView(viewModel: viewModel)
        }
    }
}
