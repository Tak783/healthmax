//
//  HealthMetricValue.swift
//  HealthMax
//
//  Created on 25/05/2025.
//

import CoreFoundational
import Foundation

public enum HealthMetricValue: Hashable, Sendable {
    case int(Int)
    case double(Double)
    case string(String)
    case bool(Bool)
    case date(Date)

    public var defaultStringValue: String {
        switch self {
        case .int(let value):
            return String(value)
        case .double(let value):
            return String(format: "%.2f", value)
        case .string(let value):
            return value
        case .bool(let value):
            return value ? "Yes" : "No"
        case .date(let value):
            let date = DateFormatter.readableDayOnlyDateFormatter.string(from: value)
            return date
        }
    }
}

// MARK: - Codable
extension HealthMetricValue: Codable {
    private enum CodingKeys: String, CodingKey {
        case int, double, string, bool, date
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        switch self {
        case .int(let value):
            try container.encode(value, forKey: .int)
        case .double(let value):
            try container.encode(value, forKey: .double)
        case .string(let value):
            try container.encode(value, forKey: .string)
        case .bool(let value):
            try container.encode(value, forKey: .bool)
        case .date(let value):
            try container.encode(value, forKey: .date)
        }
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let value = try? container.decode(Int.self, forKey: .int) {
            self = .int(value)
        } else if let value = try? container.decode(Double.self, forKey: .double) {
            self = .double(value)
        } else if let value = try? container.decode(String.self, forKey: .string) {
            self = .string(value)
        } else if let value = try? container.decode(Bool.self, forKey: .bool) {
            self = .bool(value)
        } else if let value = try? container.decode(String.self, forKey: .date) {
            let date = ISO8601DateFormatter().date(from: value)
            if let date {
                self = .date(date)
            } else {
                throw DecodingError.dataCorrupted(
                    .init(codingPath: decoder.codingPath, debugDescription: "Could not decode Date: \(value)"))
            }
        } else {
            throw DecodingError.dataCorrupted(
                .init(codingPath: decoder.codingPath, debugDescription: "Unknown RemoteHealthMetricValue"))
        }
    }
}
