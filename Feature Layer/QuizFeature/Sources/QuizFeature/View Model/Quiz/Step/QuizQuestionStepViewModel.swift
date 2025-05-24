//
//  QuizQuestionStepViewModel.swift
//  QuizFeature
//
//  Created on 23/05/2025.
//

import Foundation

@MainActor
final class QuizQuestionStepViewModel: ObservableObject {
    private(set) var currentStep: QuizStep
    private(set) var questionContent: QuizQuestionStepContent
    
    @Published var didAnswerQuestion: Bool = false
    @Published var answer: QuizAnswer
    
    public init(
        currentStep: QuizStep,
        questionContent: QuizQuestionStepContent,
        answer: QuizAnswer? = nil
    ) {
        self.currentStep = currentStep
        self.questionContent = questionContent
        if let answer {
            self.answer = answer
        } else {
            self.answer = Self.generateNewAnswer(
                forQuizQuestion: questionContent,
                step: currentStep
            )
        }
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
    
    func isDataEntryChoiceStep() -> Bool {
        switch questionContent.answerType {
        case .string, .int, .double:
            return true
        default:
            return false
        }
    }
}

// MARK: - Quiz Choice Selection
extension QuizQuestionStepViewModel {
    func didSelectAnswerChoice(_ choice: QuizAnswerChoice) {
        switch questionContent.answerType {
        case .singleChoice:
            answer.answerValue = .choice(choice.id)
        default:
            break
        }
        didAnswerQuestion = true
    }
}

// MARK: - Answers
extension QuizQuestionStepViewModel {
    static func generateNewAnswer(
        forQuizQuestion questionContent: QuizQuestionStepContent,
        step: QuizStep
    ) -> QuizAnswer {
        switch questionContent.answerType {
        case .singleChoice:
            return QuizAnswer(
                id: UUID().uuidString,
                questionID: step.id,
                answerType: .singleChoice,
                answerValue: nil
            )
        case .int:
            return QuizAnswer(
                id: UUID().uuidString,
                questionID: step.id,
                answerType: .int,
                answerValue: nil
            )
        case .string:
            return QuizAnswer(
                id: UUID().uuidString,
                questionID: step.id,
                answerType: .string,
                answerValue: nil
            )
        case .double:
            return QuizAnswer(
                id: UUID().uuidString,
                questionID: step.id,
                answerType: .double,
                answerValue: nil
            )
        case .other:
            return QuizAnswer(
                id: UUID().uuidString,
                questionID: step.id,
                answerType: .other,
                answerValue: nil
            )
        }
    }
}
