//
//  QuizMetricRequestContent.swift
//  QuizFeature
//
//  Created on 22/05/2025.
//

public struct QuizBiometricRequestContent: StepInfoModellable, Codable, Sendable {
    public var question: String
    public let answerType: QuizAnswerType
    public let biometricType: BiometricType
}
