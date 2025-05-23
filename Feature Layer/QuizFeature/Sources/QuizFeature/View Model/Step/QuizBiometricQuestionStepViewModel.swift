//
//  QuizBiometricQuestionStepViewModel.swift
//  QuizFeature
//
//  Created by Tak Mazarura on 23/05/2025.
//

import Foundation

@MainActor
final class QuizBiometricQuestionStepViewModel: ObservableObject {
    private(set) var currentStep: QuizStep
    private(set) var biometricContent: QuizBiometricRequestContent
    
    public init(
        currentStep: QuizStep,
        biometricContent: QuizBiometricRequestContent
    ) {
        self.currentStep = currentStep
        self.biometricContent = biometricContent
    }
}

// MARK: - QuizStepViewModellable
extension QuizBiometricQuestionStepViewModel: QuizStepViewModellable {
    func isContinueButtonVisible() -> Bool {
        true
    }
    
    func isContinueButtonEnabled() -> Bool {
        true
    }
}
