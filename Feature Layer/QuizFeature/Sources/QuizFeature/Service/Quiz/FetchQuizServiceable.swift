//
//  FetchQuizServiceable.swift
//  QuizFeature
//
//  Created on 23/05/2025.
//

import Foundation

public protocol FetchQuizServiceable: Sendable {
    typealias FetchQuizResult = Swift.Result<Quiz, Error>
    
    func load() async -> FetchQuizResult
}
