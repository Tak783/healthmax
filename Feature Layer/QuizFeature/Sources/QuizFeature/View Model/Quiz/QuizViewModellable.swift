//
//  QuizViewModellable.swift
//  QuizFeature
//
//  Created on 24/05/2025.
//

@MainActor
public protocol QuizViewModellable {
    func loadQuiz() async
    
    func currentStep() -> QuizStep?
    func recordAnswer(_ answer: QuizAnswer)
    func processStepAction(_ action: QuizAction)
}
