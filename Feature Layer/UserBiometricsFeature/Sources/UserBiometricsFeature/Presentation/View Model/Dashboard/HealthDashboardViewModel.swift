//
//  HealthDashboardViewModel.swift
//  HealthMax
//
//  Created on 24/05/2025.
//

import CoreHealthKit
import CoreHealthMaxModels
import CorePresentation
import Foundation

@MainActor
public final class HealthDashboardViewModel: ObservableObject {
    @Published public var isLoading = true
    @Published public private(set) var staticMetricPresentationModels = [HealthMetricPresentationModel]()
    @Published public private(set) var dynamicMetricsPresentationModels = [HealthMetricPresentationModel]()
    @Published public private(set) var feedIsEmpty = false
    
    private var staticMetrics = [HealthMetric]()
    private var dynamicMetrics = [HealthMetric]()
    
    private let healthService: HealthDataServiceable
    private let biometricsService: FetchUserBiometricsServiceable
    
    public init(
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
        
        setLocalModels(
            withBiometricsResult: results.0,
            healthMetricsResult: results.1
        )
        updatePresentationModels()
        updateFeedIsEmptyStatus()
        
        setIsLoading(false)
    }
}

// MARK: - Helpers
extension HealthDashboardViewModel {
    private func setLocalModels(
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
    
    private func updatePresentationModels() {
        staticMetricPresentationModels = staticMetrics.map { HealthMetricPresentationModel(metric: $0) }
        dynamicMetricsPresentationModels = dynamicMetrics.map { HealthMetricPresentationModel(metric: $0) }
    }
    
    private func updateFeedIsEmptyStatus() {
        feedIsEmpty = staticMetricPresentationModels.isEmpty && dynamicMetricsPresentationModels.isEmpty
    }
}
