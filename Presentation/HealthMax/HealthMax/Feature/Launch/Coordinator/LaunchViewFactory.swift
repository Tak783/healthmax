//
//  LaunchViewFactory.swift
//  HealthMax
//
//  Created by Tak Mazarura on 22/05/2025.
//

import QuizFeature
import SwiftUI

@MainActor
struct LaunchViewFactory {
    static func launchView() -> some View {
        let coordinator = LaunchCoordinator()
        return LaunchView(coordinator: coordinator)
    }
    
    static func onboardingQuiz() -> some View {
        let quizViewModel = QuizViewModel()
        return QuizView(
            quizViewModel: quizViewModel,
            finishQuiz: {},
            didTapNavigationBarBackButton: {}
        )
    }
    
    static func dashboardView() -> some View {
        Text("Dashboard")
    }
}
