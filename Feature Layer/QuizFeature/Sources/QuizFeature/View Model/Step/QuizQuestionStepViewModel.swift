//
//  QuizQuestionStepViewModel.swift
//  QuizFeature
//
//  Created by Tak Mazarura on 23/05/2025.
//

import Foundation

@MainActor
final class QuizQuestionStepViewModel: ObservableObject {
    private(set) var currentStep: QuizStep
    private(set) var questionContent: QuizQuestionStepContent
    
    @Published var didAnswerQuestion: Bool = false
    
    public init(
        currentStep: QuizStep,
        questionContent: QuizQuestionStepContent,
        answer: QuizAnswer? = nil
    ) {
        self.currentStep = currentStep
        self.questionContent = questionContent
    }
    
    func resetDidAnswerQuestion() {
        didAnswerQuestion = false
    }
}

// MARK: - QuizStepViewModellable
extension QuizQuestionStepViewModel: QuizStepViewModellable {
    func isContinueButtonVisible() -> Bool {
        isDataEntryChoiceStep()
    }
    
    func isContinueButtonEnabled() -> Bool {
        true
    }
}

// MARK: - Quiz Choice Selection
extension QuizQuestionStepViewModel {
    func isDataEntryChoiceStep() -> Bool {
        switch questionContent.answerType {
        case .string, .int, .double:
            return true
        default:
            return false
        }
    }
}
