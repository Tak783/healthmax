//
//  QuizQuestionStepViewModel.swift
//  QuizFeature
//
//  Created on 23/05/2025.
//

import UserBiometricsFeature
import Foundation

@MainActor
public final class QuizQuestionStepViewModel: ObservableObject {
    private(set) public var currentStep: QuizStep
    private(set) public var questionContent: QuizQuestionStepContent
    
    @Published public var didAnswerQuestion: Bool = false
    @Published public var answer: QuizAnswer
    
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
    public func isContinueButtonVisible() -> Bool {
        isDataEntryChoiceStep()
    }
    
    public func isContinueButtonEnabled() -> Bool {
        true
    }
    
    public func isDataEntryChoiceStep() -> Bool {
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
    public func didSelectAnswerChoice(_ choice: QuizAnswerChoice) {
        switch questionContent.answerType {
        case .singleChoice:
            answer.answerValue = .choice(choice.id)
            
            // TODO: - use a new quiz service instead of saving manually
            Task.detached {
                await UserDefaultsSaveUserBiometricsService().saveGender(choice.title)
            }
            
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
