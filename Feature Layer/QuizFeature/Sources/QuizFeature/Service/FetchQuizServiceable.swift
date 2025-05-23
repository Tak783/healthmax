//
//  FetchQuizServiceable.swift
//  QuizFeature
//
//  Created by Tak Mazarura on 23/05/2025.
//

import Foundation

public protocol FetchQuizServiceable: Sendable {
    typealias FetchQuizResult = Swift.Result<Quiz, Error>
    
    func load() async -> FetchQuizResult
}

// MARK: - FetchQuizServiceable
extension LocalFetchQuizServiceService: FetchQuizServiceable {
    public func load() async -> FetchQuizResult {
        return .success(Quiz.onboardingQuiz)
    }
}
