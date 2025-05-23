//
//  HapticImpactButton.swift
//  CorePresentation
//
//  Created by Tak Mazarura on 23/05/2025.
//

import SwiftUI

public struct HapticImpactButton<Label: View>: View {
    public let action: () -> Void
    public let label: () -> Label

    public init(action: @escaping () -> Void, label: @escaping () -> Label) {
        self.action = action
        self.label = label
    }
    
    public var body: some View {
        Button(action: {
            HapticGenerator.generateHapticImpact()
            action()
        }) {
            label()
        }
    }
}
