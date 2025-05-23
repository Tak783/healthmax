//
//  QuizStepViewModellable.swift
//  QuizFeature
//
//  Created by Tak Mazarura on 23/05/2025.
//

@MainActor
protocol QuizStepViewModellable {
    func isContinueButtonVisible() -> Bool
    func isContinueButtonEnabled() -> Bool
}
