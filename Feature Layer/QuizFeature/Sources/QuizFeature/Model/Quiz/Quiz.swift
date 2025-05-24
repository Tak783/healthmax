//
//  Quiz.swift
//  QuizFeature
//
//  Created by Tak Mazarura on 22/05/2025.
//

import Foundation

public struct Quiz: Identifiable, Codable, Sendable {
    public let id: String
    public let name: String
    public let steps: [QuizStep]
    
    public init(id: String, name: String, steps: [QuizStep]) {
        self.id = id
        self.name = name
        self.steps = steps
    }
}
