//
//  QuizStepViewModellable.swift
//  QuizFeature
//
//  Created on 23/05/2025.
//

@MainActor
public protocol QuizStepViewModellable {
    func isContinueButtonVisible() -> Bool
    func isContinueButtonEnabled() -> Bool
}
