//
//  QuizAnswerGroup.swift
//  QuizFeature
//
//  Created by Tak Mazarura on 22/05/2025.
//

import Foundation

public struct QuizAnswerGroup: Codable, Identifiable, Sendable {
    public let id: String
    public let title: String?
    public let choices: [QuizAnswerChoice]
    
    public init(id: String, title: String? = nil, choices: [QuizAnswerChoice]) {
        self.id = id
        self.title = title
        self.choices = choices
    }
}
