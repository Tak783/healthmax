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
            recommendationsView
        }
    }
    
    private var recommendationsView: some View {
        let service = HealthKitHealthDataService()
        let viewModel = SimpleRecommendationsViewModel(healthService: service)
        return RecommendationsCarouselView(viewModel: viewModel)
    }
}
