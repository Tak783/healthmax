//
//  QuizUpsellStepViewModel.swift
//  QuizFeature
//
//  Created on 23/05/2025.
//

import Foundation

@MainActor
public final class QuizUpsellStepViewModel: ObservableObject {
    public private(set) var currentStep: QuizStep
    public private(set) var upsellContent: QuizUpsellStepContent
    
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
    public func isContinueButtonVisible() -> Bool {
        true
    }
    
    public func isContinueButtonEnabled() -> Bool {
        true
    }
}
