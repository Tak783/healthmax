//
//  HapticGenerator.swift
//  CorePresentation
//
//  Created on 23/05/2025.
//

import UIKit

@MainActor
public struct HapticGenerator {
    public static func generateHapticImpact(
        _ impact: UIImpactFeedbackGenerator.FeedbackStyle = .medium
    ) {
        UIImpactFeedbackGenerator(style: impact).impactOccurred()
    }
}
