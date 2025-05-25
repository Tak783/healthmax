//
//  BloodType.swift
//  QuizFeature
//
//  Created by Tak Mazarura on 25/05/2025.
//

enum BloodType: String, CaseIterable, Identifiable {
    case aPositive = "A+"
    case aNegative = "A−"
    case bPositive = "B+"
    case bNegative = "B−"
    case abPositive = "AB+"
    case abNegative = "AB−"
    case oPositive = "O+"
    case oNegative = "O−"

    var id: String { rawValue }
    
    var displayName: String {
        rawValue
    }
}

