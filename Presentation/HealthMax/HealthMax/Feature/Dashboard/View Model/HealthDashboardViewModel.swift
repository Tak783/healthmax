//
//  HealthDashboardViewModel.swift
//  HealthMax
//
//  Created on 24/05/2025.
//

import CorePresentation
import Foundation

@MainActor
final class HealthDashboardViewModel: ObservableObject {
    @Published var isLoading: Bool = true
    @Published var staticMetrics: [HealthMetric] = []
    @Published var dynamicMetrics: [HealthMetric] = []
    
    private let healthService: HealthDataServiceable
    private let biometricsService: FetchUserBiometricsServiceable
    
    init(
        healthService: HealthDataServiceable,
        biometricsService: FetchUserBiometricsServiceable
    ) {
        self.healthService = healthService
        self.biometricsService = biometricsService
    }
}

// MARK: - ViewModelLoadable
extension HealthDashboardViewModel: ViewModelLoadable {}

// MARK: - HealthDashboardViewModellable
extension HealthDashboardViewModel: HealthDashboardViewModellable {
    public func load() async {
        setIsLoading(true)
        
        async let biometricsRequestResult = await biometricsService.fetchAllMetrics()
        async let healthMetricsRequestResult = await healthService.fetchAllMetrics(for: .now)
        
        let results = await (biometricsRequestResult, healthMetricsRequestResult)
        
        update(withBiometricsResult: results.0, healthMetricsResult: results.1)
        
        setIsLoading(false)
    }
}

// MARK: - Helpers
extension HealthDashboardViewModel {
    private func update(
        withBiometricsResult biometricsResult: MetricsFetchResult,
        healthMetricsResult: MetricsFetchResult
    ) {
        var temporayStaticMetrics = [HealthMetric]()
        if case let .success(returnedBiometrics) = biometricsResult{
            temporayStaticMetrics = returnedBiometrics
        }
     
        var finalDynamicMetrics = [HealthMetric]()
        if case let .success(returnedHealthMetrics) = healthMetricsResult {
            finalDynamicMetrics = returnedHealthMetrics
        }
        
        var finalStaticMetrics = [HealthMetric]()
        for metric in temporayStaticMetrics {
            if !finalDynamicMetrics.contains(where: { $0.type == metric.type }) {
                finalStaticMetrics.append(metric)
            }
        }
        
        staticMetrics = finalStaticMetrics
        dynamicMetrics = finalDynamicMetrics
    }
}
