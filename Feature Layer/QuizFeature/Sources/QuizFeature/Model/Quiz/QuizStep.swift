//
//  QuizStep.swift
//  QuizFeature
//
//  Created by Tak Mazarura on 22/05/2025.
//

import Foundation

public struct QuizStep: Identifiable, Codable, Sendable {
    public let id: String
    public var title: String? = nil
    public var name: String? = nil
    public var showProgressBar: Bool = true
    public let content: QuizStepContent
    
    public enum StepType: Int, Codable {
        case question
        case upsell
        case biometricRequest
        case permissionRequest
    }
}
