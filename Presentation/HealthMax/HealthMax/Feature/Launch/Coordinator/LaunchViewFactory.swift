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
    
    static func onboardingQuiz(didFinishQuiz: @escaping () -> Void?) -> some View {
        let fetchQuizService = LocalFetchQuizServiceService()
        let quizViewModel = QuizViewModel(fetchQuizService: fetchQuizService)
        return QuizView(
            quizViewModel: quizViewModel,
            finishQuiz: didFinishQuiz
        )
    }
    
    static func dashboardView() -> some View {
        Text("Dashboard")
    }
}
