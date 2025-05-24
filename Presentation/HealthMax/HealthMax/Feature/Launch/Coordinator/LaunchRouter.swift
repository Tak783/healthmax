//
//  LaunchRouter.swift
//  HealthMax
//
//  Created by Tak Mazarura on 22/05/2025.
//

import SwiftUI

@MainActor
struct LaunchRouter {
    @ViewBuilder
    static func navigateToDestination(
        _ destination: LaunchCoordinator.NavigationDestination,
        coordinator: LaunchCoordinator
    ) -> some View {
        switch destination {
        case .dashboard:
            LaunchViewFactory.dashboardView()
        case .onboardingQuiz:
            LaunchViewFactory.onboardingQuiz(
                didFinishQuiz: {
                    coordinator.navigateToDashboard()
                }
            )
        }
    }
}
