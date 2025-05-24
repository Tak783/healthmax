//
//  Untitled.swift
//  QuizFeature
//
//  Created on 22/05/2025.
//

import Foundation

public struct QuizQuestionStepContent: StepInfoModellable, Codable, Sendable {
    public var title: String?
    public var question: String
    public let answerType: QuizAnswerType
    public let answerGroup: [QuizAnswerGroup]

    public init(
        title: String? = nil,
        question: String,
        answerType: QuizAnswerType,
        continueButtonTitle: String = "Continue",
        answerGroup: [QuizAnswerGroup]
    ) {
        self.title = title
        self.question = question
        self.answerType = answerType
        self.answerGroup = answerGroup
    }
}
