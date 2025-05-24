//
//  LocalFetchQuizServiceService.swift
//  QuizFeature
//
//  Created by Tak Mazarura on 23/05/2025.
//

import Foundation
public struct LocalFetchQuizServiceService: Sendable {
    public init() {}
}

// MARK: - FetchQuizServiceable
extension LocalFetchQuizServiceService: FetchQuizServiceable {
    public func load() async -> FetchQuizResult {
        return .success(Self.onboardingQuiz)
    }
}

extension LocalFetchQuizServiceService {
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
                content: .question(
                    QuizQuestionStepContent(
                        question: "Choose your gender",
                        answerType: .singleChoice,
                        answerGroup: [
                            QuizAnswerGroup(
                                id: UUID().uuidString,
                                title: .init(),
                                choices: [
                                    .init(id: UUID().uuidString, title: "Male"),
                                    .init(id: UUID().uuidString, title: "Female"),
                                    .init(id: UUID().uuidString, title: "Other")
                                ]
                            )
                        ]
                    )
                )
            ),
            QuizStep(
                id: UUID().uuidString,
                content: .biometric(
                    QuizBiometricRequestContent(
                        question: "When were you born?",
                        answerType: .string,
                        biometricType: .dateOfBirth
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
                content: .biometric(
                    QuizBiometricRequestContent(
                        question: "How much do you weigh?",
                        answerType: .int,
                        biometricType: .weight
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
            ),
            QuizStep(
                id: UUID().uuidString,
                content: .biometric(
                    QuizBiometricRequestContent(
                        question: "How tall are you?",
                        answerType: .double,
                        biometricType: .height
                    )
                )
            ),
            QuizStep(
                id: UUID().uuidString,
                content: .permission(
                    QuizPermissionRequestContent(
                        question: .init(),
                        answerType: .other,
                        permissionRequestType: .appleHealth,
                        image: .init(name: "AppleHealthLogo", type: .asset),
                        title: "Connect to Apple Health to tell the full story of your health",
                        detail: "85% of users that connect their Apple health see faster improvements with their health"
                    )
                )
            ),
            QuizStep(
                id: UUID().uuidString,
                content: .permission(
                    QuizPermissionRequestContent(
                        question: .init(),
                        answerType: .other,
                        permissionRequestType: .notifications,
                        image: .init(name: "🧪", type: .emoji),
                        title: "We are now making a custom plan for you",
                        detail: "You will receive a notification when it is ready"
                    )
                )
            ),
            QuizStep(
                id: UUID().uuidString,
                content: .upsell(
                    QuizUpsellStepContent(
                        emoji: "💚",
                        question: "Your personalised plan will be with you shortly",
                        detail: "Get ready to maximise your health",
                        answerType: .other
                    )
                )
            ),
        ]
    )
}
