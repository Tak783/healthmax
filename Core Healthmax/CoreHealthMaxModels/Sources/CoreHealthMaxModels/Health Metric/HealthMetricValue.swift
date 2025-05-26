//
//  HealthMetricValue.swift
//  HealthMax
//
//  Created by Tak Mazarura on 25/05/2025.
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
