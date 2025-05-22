//
//  Quiz.swift
//  QuizFeature
//
//  Created by Tak Mazarura on 22/05/2025.
//

import Foundation

public struct Quiz: Identifiable, Codable, Sendable {
    public let id: String
    public let name: String
    public let steps: [QuizStep]
    
    public init(id: String, name: String, steps: [QuizStep]) {
        self.id = id
        self.name = name
        self.steps = steps
    }
}


extension Quiz {
    static let onboardingQuiz = Quiz(
        id: UUID().uuidString,
        name: "BiometricPermisson",
        steps: [
            QuizStep(
                id: UUID().uuidString,
                content: .upsell(
                    QuizUpsellStepContent(
                        emoji: "💚",
                        question: "Lets start by understanding your core health metrics",
                        detail: "With this information we will create personalised health improvement programme for you",
                        answerType: .other
                    )
                )
            ),
            QuizStep(
                id: UUID().uuidString,
                content: .upsell(
                    QuizUpsellStepContent(
                        emoji: "🚀",
                        question: "No matter your gender, or age your can maximise your health ",
                        detail: "95% of users see obvious results with healthMax.AI and find it easy to maintain their progress",
                        answerType: .other
                    )
                )
            ),
            QuizStep(
                id: UUID().uuidString,
                content: .upsell(
                    QuizUpsellStepContent(
                        emoji: "💪",
                        question: "Reach your ideal weight with HEALTHMAX.AI",
                        detail: "Adults at a healthy weight live, on average, 3 to 10 years longer than those who are overweight or obese.",
                        answerType: .other
                    )
                )
            )
        ]
    )
}
