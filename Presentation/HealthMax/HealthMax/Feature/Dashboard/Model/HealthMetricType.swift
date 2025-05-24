//
//  HealthMetricType.swift
//  HealthMax
//
//  Created by Tak Mazarura on 24/05/2025.
//

import CorePresentation

enum HealthMetricType: String, CaseIterable, Codable, Sendable, Hashable {
    case weight
    case steps
    case heartRate
    case bloodGlucose
    case calories
    case bodyTemperature
    case bloodPressure

    public var displayName: String {
        switch self {
        case .weight: 
            return "Weight"
        case .steps: 
            return "Steps"
        case .heartRate: 
            return "Heart Rate"
        case .bloodGlucose:
            return "Blood Glucose"
        case .calories:
            return "Calories"
        case .bodyTemperature: 
            return "Temperature"
        case .bloodPressure:
            return "Blood Pressure"
        }
    }

    public var icon: LocalImage {
        switch self {
        case .weight:
            return .init(name: "⚖️", type: .emoji)
        case .steps:
            return .init(name: "🦶", type: .emoji)
        case .heartRate:
            return .init(name: "❤️", type: .emoji)
        case .bloodGlucose:
            return .init(name: "🩸", type: .emoji)
        case .calories:
            return .init(name: "🔥", type: .emoji)
        case .bodyTemperature:
            return .init(name: "🥵", type: .emoji)
        case .bloodPressure:
            return .init(name: "waveform.path.ecg", type: .system)
        }
    }
}
