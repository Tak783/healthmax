//
//  QuizSessionModel.swift
//  QuizFeature
//
//  Created by Tak Mazarura on 23/05/2025.
//

import Foundation

public final class QuizSessionModel {
    public private(set) var quiz: Quiz
    public private(set) var answers: [QuizAnswer]
    public private(set) var currentStep: QuizStep
    public private(set) var quizProgress: QuizProgress
    
    public init(
        quiz: Quiz,
        withCurrentIndex index: Int = .zero,
        answers: [QuizAnswer] = .init()
    ) {
        let totalStepIndexes = quiz.steps.indices.count
        
        self.quiz = quiz
        self.answers = answers
        self.currentStep = quiz.steps[index]
        self.quizProgress = QuizProgress(totalStepIndexes: totalStepIndexes, currentStepIndex: index)
        
    }
}

// MARK: - Helpers
extension QuizSessionModel {
    func recordAnswer(_ answer: QuizAnswer) {
        if let index = answers.firstIndex(where: { $0.questionID == answer.questionID }) {
            answers[index] = answer
        } else {
            answers.append(answer)
        }
    }
    
    func answer(forQuestionID questionID: String) -> QuizAnswer? {
        guard let answer = answers.first(where: { $0.questionID == questionID }) else {
            return nil
        }
        return answer
    }
    
    func updateCurrentStep(withIndex nextIndex: Int) {
        guard quiz.steps.indices.contains(nextIndex) else {
            return
        }
        currentStep = quiz.steps[nextIndex]
        quizProgress.currentStepIndex = nextIndex
    }
}
