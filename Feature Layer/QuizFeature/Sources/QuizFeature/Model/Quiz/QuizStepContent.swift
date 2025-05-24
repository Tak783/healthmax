//
//  QuizStepContent.swift
//  QuizFeature
//
//  Created on 22/05/2025.
//

import Foundation

public protocol StepInfoModellable {
    var question: String { get }
}

public enum QuizStepContent: Codable, StepInfoModellable, Sendable {
    case question(QuizQuestionStepContent)
    case upsell(QuizUpsellStepContent)
    case biometric(QuizBiometricRequestContent)
    case permission(QuizPermissionRequestContent)
    
    public var question: String {
        switch self {
        case .question(let model):
            return model.question
        case .upsell(let model):
            return model.question
        case .biometric(let model):
            return model.question
        case .permission(let model):
            return model.question
        }
    }

    public var quizAnswerType: QuizAnswerType {
        switch self {
        case .question(let model):
            return model.answerType
        case .upsell(let model):
            return model.answerType
        case .biometric(let model):
            return model.answerType
        case .permission(let model):
            return model.answerType
        }
    }

    private enum CodingKeys: String, CodingKey {
        case type
        case data
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(QuizStep.StepType.self, forKey: .type)

        switch type {
        case .question:
            let data = try container.decode(QuizQuestionStepContent.self, forKey: .data)
            self = .question(data)
        case .upsell:
            let data = try container.decode(QuizUpsellStepContent.self, forKey: .data)
            self = .upsell(data)
        case .biometricRequest:
            let data = try container.decode(QuizBiometricRequestContent.self, forKey: .data)
            self = .biometric(data)
        case .permissionRequest:
            let data = try container.decode(QuizPermissionRequestContent.self, forKey: .data)
            self = .permission(data)
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        switch self {
        case .question(let data):
            try container.encode(QuizStep.StepType.question, forKey: .type)
            try container.encode(data, forKey: .data)
        case .upsell(let data):
            try container.encode(QuizStep.StepType.upsell, forKey: .type)
            try container.encode(data, forKey: .data)
        case .biometric(let data):
            try container.encode(QuizStep.StepType.biometricRequest, forKey: .type)
            try container.encode(data, forKey: .data)
        case .permission(let data):
            try container.encode(QuizStep.StepType.permissionRequest, forKey: .type)
            try container.encode(data, forKey: .data)
        }
    }
}
