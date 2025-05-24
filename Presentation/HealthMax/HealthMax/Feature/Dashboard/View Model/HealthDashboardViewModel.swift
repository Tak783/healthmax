//
//  HealthDashboardViewModel.swift
//  HealthMax
//
//  Created by Tak Mazarura on 24/05/2025.
//

import CorePresentation
import Foundation

@MainActor
final class HealthDashboardViewModel: ObservableObject {
    @Published var isLoading: Bool = false
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

        async let biometricsResult = await biometricsService.fetchAllMetrics()
        async let healthMetricsResult = await healthService.fetchAllMetrics(for: .now)
        
        let results = await (biometricsResult, healthMetricsResult)
        
        if case let .success(returnedBiometrics) = results.0 {
            staticMetrics = returnedBiometrics
        }
     
        if case let .success(returnedHealthMetrics) = results.1 {
            dynamicMetrics = returnedHealthMetrics
        }

        setIsLoading(false)
    }
}
