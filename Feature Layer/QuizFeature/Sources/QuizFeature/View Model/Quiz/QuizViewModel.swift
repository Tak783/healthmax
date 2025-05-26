//
//  QuizViewModel.swift
//  QuizFeature
//
//  Created on 22/05/2025.
//

import Foundation
import CoreFoundational
import SwiftUI

@MainActor
public final class QuizViewModel: ObservableObject {
    @Published public var isLoading = false
    @Published public var stepIndex = 0
    @Published public private(set) var didFinishQuiz = false
    @Published public private(set) var isSavingQuizAnswers = false
    
    private let fetchQuizService: FetchQuizServiceable
    public private(set) var quizSessionModel: QuizSessionModel?
    
    public enum Error: Swift.Error {
        case goToNextStepNotPossible
    }
    
    public init(fetchQuizService: FetchQuizServiceable) {
        self.fetchQuizService = fetchQuizService
    }
}

// MARK: - ViewModelLoadable
extension QuizViewModel: ViewModelLoadable {}

// MARK: - QuizViewModellable
extension QuizViewModel: QuizViewModellable {
    public func loadQuiz() async {
        setIsLoading(true)
        let result = await fetchQuizService.load()
        switch result {
        case .success(let quiz):
            self.quizSessionModel = QuizSessionModel(quiz: quiz)
        case .failure(let error):
            safePrint(error.localizedDescription)
        }
        setIsLoading(false)
    }
    
    public func currentStep() -> QuizStep? {
        guard let quizSessionModel else {
            return nil
        }
        return quizSessionModel.currentStep
    }
    
    public func processStepAction(_ action: QuizAction) {
        switch action {
        case .closeQuiz:
            break
        case .finishStep:
            goToNextStepIfValid()
        }
    }
    
    public func recordAnswer(_ answer: QuizAnswer) {
        guard let quizSessionModel else {
            return
        }
        quizSessionModel.recordAnswer(answer)
        
        if answer.answerType == .singleChoice {
            processStepAction(.finishStep)
        }
    }
}

// MARK: - Go To Next Step
extension QuizViewModel {
    private func goToNextStep() {
        guard let quizSessionModel else {
            return
        }
        guard let nextIndex = nextIndex() else {
            setDidFinishQuiz()
            return
        }
        
        quizSessionModel.updateCurrentStep(withIndex: nextIndex)
        self.stepIndex = nextIndex
    }
    
    private func nextIndex() -> Int? {
        guard let quizSessionModel else {
            return nil
        }
        let nextIndex = stepIndex + 1
        guard nextIndex < quizSessionModel.quiz.steps.count else {
            return nil
        }
        return nextIndex
    }
    
    private func goToNextStepIfValid() {
        guard let quizSessionModel else {
            return
        }
        let currentStep = quizSessionModel.currentStep
        switch currentStep.content {
        case .question( _):
            guard
                let answer = quizSessionModel.answers.first(where: { $0.questionID == currentStep.id }),
                answer.isValid else {
                return
            }
            goToNextStep()
        default:
            goToNextStep()
        }
    }
}

// MARK: - Helpers
extension QuizViewModel {
    private func setDidFinishQuiz() {
        self.didFinishQuiz = true
    }
}
