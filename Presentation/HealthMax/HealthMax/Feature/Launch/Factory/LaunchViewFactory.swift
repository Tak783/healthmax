//
//  LaunchViewFactory.swift
//  HealthMax
//
//  Created on 22/05/2025.
//

import CoreHealthMaxModels
import CoreHealthKit
import QuizFeature
import QuizFeatureUI
import SwiftUI
import UserBiometricsFeature

@MainActor
struct LaunchViewFactory {
    static func launchView() -> some View {
        let coordinator = LaunchCoordinator()
        return LaunchView(coordinator: coordinator)
    }
    
    static func onboardingQuiz(didFinishQuiz: @escaping () -> Void?) -> some View {
        let fetchQuizService = LocalFetchQuizServiceService()
        let quizViewModel = QuizViewModel(fetchQuizService: fetchQuizService)
        return QuizView(
            quizViewModel: quizViewModel,
            finishQuiz: didFinishQuiz
        )
    }
    
    static func dashboardView() -> some View {
        let healthService = HealthKitHealthDataService()
        let biometricsService = UserDefaultsFetchUserBiometricsService()
        
        let healthDashboardViewModel = HealthDashboardViewModel(
            healthService: healthService,
            biometricsService: biometricsService
        )
        return HealthDashboardView(viewModel: healthDashboardViewModel)
    }
}
