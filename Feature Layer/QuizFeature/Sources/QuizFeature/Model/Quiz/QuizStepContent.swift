//
//  QuizStepContent.swift
//  QuizFeature
//
//  Created by Tak Mazarura on 22/05/2025.
//

public protocol StepInfoModellable {
    var question: String { get }
}

public enum QuizStepContent: Codable, StepInfoModellable, Sendable {
    case question(QuizQuestionStepContent)
    case upsell(QuizUpsellStepContent)
    case scoreCalculation(QuizScoreCalculationStepContent)
    case score(QuizScoreStepContent)
    case userProfileForm(QuizUserProfileFormStepContent)
    
    public var question: String {
        switch self {
        case .question(let model):
            return model.question
        case .upsell(let model):
            return model.question
        case .scoreCalculation(let model):
            return model.question
        case .score(let model):
            return model.question
        case .userProfileForm(let model):
            return model.question
        }
    }

    public var quizAnswerType: QuizAnswerType {
        switch self {
        case .question(let model):
            return model.answerType
        case .upsell(let model):
            return model.answerType
        case .scoreCalculation(let model):
            return model.answerType
        case .score(let model):
            return model.answerType
        case .userProfileForm(let model):
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
        case .score:
            let data = try container.decode(QuizScoreStepContent.self, forKey: .data)
            self = .score(data)
        case .scoreCalculation:
            let data = try container.decode(QuizScoreCalculationStepContent.self, forKey: .data)
            self = .scoreCalculation(data)
        case .userProfileForm:
            let data = try container.decode(QuizUserProfileFormStepContent.self, forKey: .data)
            self = .userProfileForm(data)
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
        case .score(let data):
            try container.encode(QuizStep.StepType.score, forKey: .type)
            try container.encode(data, forKey: .data)
        case .scoreCalculation(let data):
            try container.encode(QuizStep.StepType.scoreCalculation, forKey: .type)
            try container.encode(data, forKey: .data)
        case .userProfileForm(let data):
            try container.encode(QuizStep.StepType.userProfileForm, forKey: .type)
            try container.encode(data, forKey: .data)
        }
    }
}
