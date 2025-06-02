//
//  RecommendationsViewModel.swift
//  HealthMax
//
//  Created by Tak Mazarura on 02/06/2025.
//

import CoreFoundational
import CoreHealthKit
import CoreHealthMaxModels
import CorePresentation
import Foundation
import UserBiometricsFeature

@MainActor
final class RecommendationsViewModel: ObservableObject {
    @Published var isLoading = true
    @Published private(set) var feedIsEmpty = false
    
    private var staticMetrics = [HealthMetric]()
    private var dynamicMetrics = [HealthMetric]()
    private var recommendations = [HealthImprovementRecommendation]()
    
    private let healthService: HealthDataServiceable
    private let biometricsService: FetchUserBiometricsServiceable
    private let recommendationService: HealthRecommendationServiceable

    init(
        healthService: HealthDataServiceable,
        biometricsService: FetchUserBiometricsServiceable,
        recommendationService: HealthRecommendationServiceable
    ) {
        self.healthService = healthService
        self.biometricsService = biometricsService
        self.recommendationService = recommendationService
    }
}

// MARK: - ViewModelLoadable
extension RecommendationsViewModel: ViewModelLoadable {}

// MARK: - RecommendationsViewModellable
extension RecommendationsViewModel: HealthDashboardViewModellable {
    func load() async {
        setIsLoading(true)

        async let biometricsResult = biometricsService.fetchAllMetrics()
        async let healthResult = healthService.fetchAllMetrics(for: .now)
        
        let results = await (biometricsResult, healthResult)
        
        setLocalModels(
            withBiometricsResult: results.0,
            healthMetricsResult: results.1
        )
        
        let combined = staticMetrics + dynamicMetrics
        let remotes = combined.map(RemoteHealthMetric.init)

        let result = await recommendationService.getRecommendations(for: remotes)
        
        switch result {
        case .success(let response):
            recommendations = response
            safePrint("✅ Successfully retrieved \(response.count) recommendations")
        case .failure(let error):
            safePrint("❌ Failed to fetch recommendations: \(error.localizedDescription)")
        }

        updateFeedIsEmptyStatus()
        setIsLoading(false)
    }
}
 
// MARK: - Helpers
extension RecommendationsViewModel {
    private func setLocalModels(
        withBiometricsResult biometricsResult: MetricsFetchResult,
        healthMetricsResult: MetricsFetchResult
    ) {
        var tempStatic = [HealthMetric]()
        if case let .success(biometrics) = biometricsResult {
            tempStatic = biometrics
        }

        var tempDynamic = [HealthMetric]()
        if case let .success(healthMetrics) = healthMetricsResult {
            tempDynamic = healthMetrics
        }

        staticMetrics = metricsWithDuplicatesRemoved(static: tempStatic, dynamic: tempDynamic)
        dynamicMetrics = tempDynamic
    }

    private func metricsWithDuplicatesRemoved(
        static tempStatic: [HealthMetric],
        dynamic tempDynamic: [HealthMetric]
    ) -> [HealthMetric] {
        tempStatic.filter { staticMetric in
            !tempDynamic.contains(where: { $0.type == staticMetric.type })
        }
    }

    private func updateFeedIsEmptyStatus() {
        feedIsEmpty = staticMetrics.isEmpty && dynamicMetrics.isEmpty
    }
}
