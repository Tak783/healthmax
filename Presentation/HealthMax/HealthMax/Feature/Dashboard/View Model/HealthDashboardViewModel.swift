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
    @Published var items: [HealthDashboardPresentationModel] = []
    
    private let healthService: HealthDataServiceable
    
    init(healthService: HealthDataServiceable) {
        self.healthService = healthService
    }
}

// MARK: - ViewModelLoadable
extension HealthDashboardViewModel: ViewModelLoadable {}

// MARK: - HealthDashboardViewModellable
extension HealthDashboardViewModel: HealthDashboardViewModellable {
    public func userAuthorised() -> Bool {
        healthService.userAuthorized()
    }
    
    public func load() async {
        guard userAuthorised() else {
            return
        }
        setIsLoading(true)

        let metrics = await healthService.fetchAllMetrics(for: .now)

        items = metrics.map {
            HealthDashboardPresentationModel(
                title: $0.title,
                detail: $0.value,
                image: $0.image
            )
        }

        setIsLoading(false)
    }
}
