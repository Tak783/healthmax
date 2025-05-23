//
//  QuizViewModel.swift
//  QuizFeature
//
//  Created by Tak Mazarura on 22/05/2025.
//

import Foundation
import CoreFoundational
import CorePresentation
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

    public enum Action {
        case closeQuiz, finishStep
    }
    
    public init(fetchQuizService: FetchQuizServiceable) {
        self.fetchQuizService = fetchQuizService
    }
}

// MARK: - ViewModelLoadable
extension QuizViewModel: ViewModelLoadable {}

// MARK: - Load Quiz
extension QuizViewModel {
    public func loadQuiz() {
        Task { [weak self] in
            guard let self else {
                return
            }
            self.setIsLoading(true)
            let result = await fetchQuizService.load()
            switch result {
            case .success(let quiz):
                self.quizSessionModel = QuizSessionModel(quiz: quiz)
            case .failure(let error):
                efficientPrint(error.localizedDescription)
            }
            setIsLoading(false)
        }
    }
}

// MARK: - Process Quiz Actions
extension QuizViewModel {
    func processStepAction(_ action: Action) {
        switch action {
        case .closeQuiz:
            break
        case .finishStep:
            goToNextStepIfValid()
        }
    }
    
    private func setDidFinishQuiz() {
        self.didFinishQuiz = true
    }
}

// MARK: - Quiz Choice Selection
extension QuizViewModel {
    func recordAnswer(_ answer: QuizAnswer) {
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
    func currentStep() -> QuizStep? {
        guard let quizSessionModel else {
            return nil
        }
        return quizSessionModel.currentStep
    }
    
    func setIsSavingQuizAnswers(_ isSavingQuizAnswers: Bool) {
        DispatchQueue.main.async {
            self.isSavingQuizAnswers = isSavingQuizAnswers
        }
    }
}
