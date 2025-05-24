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
    case gender
    case birthday
    case height
    
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
        case .gender:
            return "Gender"
        case .birthday:
            return "Birthday"
        case .height:
            return "Height"
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
        case .gender:
            return .init(name: "🧑", type: .emoji)
        case .birthday:
            return .init(name: "🎂", type: .emoji)
        case .height:
            return .init(name: "ruler", type: .system)
        }
    }
}
