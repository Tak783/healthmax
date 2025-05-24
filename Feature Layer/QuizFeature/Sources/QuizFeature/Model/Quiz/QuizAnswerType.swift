//
//  QuizAnswerType.swift
//  QuizFeature
//
//  Created on 22/05/2025.
//

import Foundation

public enum QuizAnswerType: Int, Codable, Sendable {
    case singleChoice
    case string
    case double
    case int
    case other
}
