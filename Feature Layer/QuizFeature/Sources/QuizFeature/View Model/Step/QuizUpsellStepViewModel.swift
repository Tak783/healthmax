//
//  QuizUpsellStepViewModel.swift
//  QuizFeature
//
//  Created by Tak Mazarura on 23/05/2025.
//

import Foundation

@MainActor
final class QuizUpsellStepViewModel: ObservableObject {
    private(set) var currentStep: QuizStep
    private(set) var upsellContent: QuizUpsellStepContent
    
    public init(
        currentStep: QuizStep,
        upsellContent: QuizUpsellStepContent
    ) {
        self.currentStep = currentStep
        self.upsellContent = upsellContent
    }
}

// MARK: - QuizStepViewModellable
extension QuizUpsellStepViewModel: QuizStepViewModellable {
    func isContinueButtonVisible() -> Bool {
        true
    }
    
    func isContinueButtonEnabled() -> Bool {
        true
    }
}
