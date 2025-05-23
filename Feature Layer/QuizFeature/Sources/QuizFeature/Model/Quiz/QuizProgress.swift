//
//  QuizProgress.swift
//  QuizFeature
//
//  Created by Tak Mazarura on 23/05/2025.
//

public struct QuizProgress {
    public let totalStepIndexes: Int
    public var currentStepIndex: Int
    public var showsStepCount: Bool = false
    public var showsProgressPercentage: Bool = false

    public var progress: Double {
        guard totalStepIndexes > 0 else { return 0 }
        return Double(currentStepIndex) / Double(totalStepIndexes)
    }

    public var isComplete: Bool {
        currentStepIndex >= totalStepIndexes
    }
}
