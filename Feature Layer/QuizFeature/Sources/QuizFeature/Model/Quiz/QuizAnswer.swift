//
//  QuizAnswer.swift
//  QuizFeature
//
//  Created by Tak Mazarura on 23/05/2025.
//

import Foundation

public struct QuizAnswer: Identifiable, Codable, Equatable, Sendable {
    public let id: String
    public let questionID: String
    public let answerType: QuizAnswerType
    public var answerValue: AnswerValue?
    public var score: Int?

    public enum AnswerValue: Codable, Equatable, Sendable {
        case choice(String)
        case multipleChoice([String])
        case string(String)
        case int(Int)
        case double(Double)

        enum CodingKeys: String, CodingKey {
            case type, value
        }

        enum QuizAnswerTypeKey: String, Codable {
            case choice, multipleChoice, string, int, double
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)

            switch self {
            case .choice(let id):
                try container.encode(QuizAnswerTypeKey.choice, forKey: .type)
                try container.encode(id, forKey: .value)

            case .multipleChoice(let ids):
                try container.encode(QuizAnswerTypeKey.multipleChoice, forKey: .type)
                try container.encode(ids.map { $0 }, forKey: .value)

            case .string(let str):
                try container.encode(QuizAnswerTypeKey.string, forKey: .type)
                try container.encode(str, forKey: .value)

            case .int(let intVal):
                try container.encode(QuizAnswerTypeKey.int, forKey: .type)
                try container.encode(intVal, forKey: .value)
            
            case .double(let doubleVal):
                try container.encode(QuizAnswerTypeKey.double, forKey: .type)
                try container.encode(doubleVal, forKey: .value)
            }
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let type = try container.decode(QuizAnswerTypeKey.self, forKey: .type)

            switch type {
            case .choice:
                let idString = try container.decode(String.self, forKey: .value)
                self = .choice(idString)

            case .multipleChoice:
                let idStrings = try container.decode([String].self, forKey: .value)
                self = .multipleChoice(idStrings)
            case .string:
                let str = try container.decode(String.self, forKey: .value)
                self = .string(str)

            case .int:
                let intVal = try container.decode(Int.self, forKey: .value)
                self = .int(intVal)
            case .double:
                let doubleVal = try container.decode(Double.self, forKey: .value)
                self = .double(doubleVal)
            }
        }
    }
}

extension QuizAnswer {
    public var isValid: Bool {
        switch answerType {
        case .singleChoice:
            guard case .choice(let choice) = answerValue, choice.isEmpty == false else {
                return false
            }
            return true
        case .string:
            guard case .string(let answerString) = answerValue, answerString.isEmpty == false else {
                return false
            }
            return true
        case .int:
            guard case .int(_) = answerValue else {
                return false
            }
            return true
        case .other:
            return true
        case .double:
            guard case .double(_) = answerValue else {
                return false
            }
            return true
        }
    }
}

extension QuizAnswer.AnswerValue {
    public var choiceID: String? {
        if case .choice(let id) = self {
            return id
        }
        return nil
    }
}
