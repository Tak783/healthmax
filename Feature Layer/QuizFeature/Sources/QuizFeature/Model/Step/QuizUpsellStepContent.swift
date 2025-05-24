//
//  QuizUpsellStepContent.swift
//  QuizFeature
//
//  Created on 22/05/2025.
//

import Foundation

public struct QuizUpsellStepContent: StepInfoModellable, Codable, Sendable {
    public var emoji: String
    public var question: String
    public var detail: String
    public var answerType: QuizAnswerType = .other
}
