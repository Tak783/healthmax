//
//  DisableTabViewSwipeGestureModifier.swift
//  CorePresentation
//
//  Created on 23/05/2025.
//

import SwiftUI

public struct DisableTabViewSwipeGestureModifier: ViewModifier {
    public var isEnabled: Bool

    public func body(content: Content) -> some View {
        content
            .onAppear {
                UIScrollView.appearance().isScrollEnabled = !isEnabled
            }
            .onDisappear {
                // Re-enable when the view disappears (optional safety)
                UIScrollView.appearance().isScrollEnabled = true
            }
    }
}

extension View {
    public func disableTabViewSwipeGesture(_ isEnabled: Bool = true) -> some View {
        self.modifier(DisableTabViewSwipeGestureModifier(isEnabled: isEnabled))
    }
}
