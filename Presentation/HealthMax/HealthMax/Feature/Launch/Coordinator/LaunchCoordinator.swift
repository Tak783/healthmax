//
//  LaunchCoordinator.swift
//  HealthMax
//
//  Created by Tak Mazarura on 22/05/2025.
//

import SwiftUI

@MainActor
final class LaunchCoordinator: ObservableObject {
    @Published var navigationPath = NavigationPath()
    
    enum NavigationDestination: Hashable {
        case onboardingQuiz
        case dashboard
    }
   
    func navigateToOnboardingQuzi() {
        navigate(toDestination: .onboardingQuiz)
    }
    
    func navigateToDashboard() {
        navigate(toDestination: .dashboard)
    }
}

// MARK: - Coordinating
extension LaunchCoordinator: Coordinating {
    typealias Destination = NavigationDestination
}
