//
//  StyledHapticButton.swift
//  CorePresentation
//
//  Created on 23/05/2025.
//

import SwiftUI

public struct StyledHapticButton: View {
    public let title: String
    public let appearance: Appearance
    public let state: State
    public let action: () -> Void
    
    public init(
        title: String,
        appearance: Appearance = Appearance.default,
        state: State = State.default,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.appearance = appearance
        self.state = state
        self.action = action
    }

    public var body: some View {
        if state.isVisible {
            HapticImpactButton {
                action()
            } label: {
                buttonContent
            }
            .disabled(!state.isEnabled)
        }
    }
}

// MARK: - Supporting Object Types
extension StyledHapticButton {
    public struct Appearance {
        public let backgroundColor: Color
        public let borderColor: Color?
        public let textColor: Color
        public let localImage: LocalImage?
        public let imageLocation: ImageLocation?
        public let cornerRadius: CGFloat

        public init(
            backgroundColor: Color,
            borderColor: Color? = nil,
            textColor: Color,
            localImage: LocalImage? = nil,
            imageLocation: ImageLocation? = nil,
            cornerRadius: CGFloat
        ) {
            self.backgroundColor = backgroundColor
            self.borderColor = borderColor
            self.textColor = textColor
            self.localImage = localImage
            self.imageLocation = imageLocation
            self.cornerRadius = cornerRadius
        }
        
        @MainActor public static let `default` = Appearance(
            backgroundColor: .black,
            borderColor: .black.opacity(0.7),
            textColor: .white,
            localImage: nil,
            imageLocation: .leading,
            cornerRadius: 12
        )
    }
    
    public enum ImageLocation: Int, Codable {
        case leading, trailing
    }

    public struct State {
        public let isEnabled: Bool
        public let isVisible: Bool

        @MainActor public static let `default` = State(
            isEnabled: true,
            isVisible: true
        )
        
        public init(isEnabled: Bool, isVisible: Bool) {
            self.isEnabled = isEnabled
            self.isVisible = isVisible
        }
    }
}

// MARK: - Supporting Views
extension StyledHapticButton {
    private var buttonContent: some View {
        let opacity = state.isEnabled ? 1 : 0.95
        let textColour = state.isEnabled ? appearance.textColor : .gray
        return HStack(spacing: 8) {
            if let imageLocation = appearance.imageLocation, imageLocation == .leading {
                imageView(withTextColor: textColour)
            }
            Text(title)
                .foregroundColor(textColour)
            if let imageLocation = appearance.imageLocation, imageLocation == .trailing {
                imageView(withTextColor: textColour)
            }
        }
        .font(.body)
        .frame(maxWidth: .infinity)
        .padding()
        .background(buttonBackground)
        .cornerRadius(appearance.cornerRadius)
        .overlay(buttonBorder)
        .opacity(opacity)
    }

    @ViewBuilder
    private func imageView(withTextColor color: Color) -> some View {
        if let localImage = appearance.localImage {
            switch localImage.type {
            case .system:
                Image(systemName: localImage.name)
                    .foregroundColor(appearance.textColor)
                    .tint(appearance.textColor)
            case .emoji:
                Text(localImage.name)
                    .foregroundColor(appearance.textColor)
            case .asset:
                Image(localImage.name)
            }
        } else {
            EmptyView()
        }
    }

    private var buttonBackground: Color {
        state.isEnabled ? appearance.backgroundColor : Color.gray.opacity(0.3)
    }

    @ViewBuilder
    private var buttonBorder: some View {
        if let borderColor = appearance.borderColor {
            RoundedRectangle(cornerRadius: appearance.cornerRadius)
                .stroke(borderColor, lineWidth: 4)
        } else {
            EmptyView()
        }
    }
}
