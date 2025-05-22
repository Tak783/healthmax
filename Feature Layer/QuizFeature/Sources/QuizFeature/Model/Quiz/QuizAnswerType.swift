//
//  QuizAnswerType.swift
//  QuizFeature
//
//  Created by Tak Mazarura on 22/05/2025.
//

public enum QuizAnswerType: Int, Codable, Sendable {
    case singleChoice
    case string
    case double
    case int
    case other
}
