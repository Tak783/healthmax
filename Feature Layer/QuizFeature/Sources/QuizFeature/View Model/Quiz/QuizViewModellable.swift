//
//  QuizViewModellable.swift
//  QuizFeature
//
//  Created by Tak Mazarura on 24/05/2025.
//

@MainActor
protocol QuizViewModellable {
    func loadQuiz() async
    
    func currentStep() -> QuizStep?
    func recordAnswer(_ answer: QuizAnswer)
    func processStepAction(_ action: QuizAction)
}
