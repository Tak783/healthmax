//
//  MetricsErrorView.swift
//  HealthMax
//
//  Created by Tak Mazarura on 25/05/2025.
//

import CorePresentation
import SwiftUI

public struct MetricsErrorView: View {
    public let retryAction: () -> Void

    public init(retryAction: @escaping () -> Void) {
        self.retryAction = retryAction
    }

    public var body: some View {
        VStack(spacing: DesignSystem.Layout.extraLarge) {
            errorIcon
            titleText
            subtitleText
            retryButton
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - Subviews
private extension MetricsErrorView {
    var errorIcon: some View {
        Image(systemName: "exclamationmark.triangle.fill")
            .resizable()
            .scaledToFit()
            .frame(width: 45, height: 45)
            .foregroundColor(.orange)
    }

    var titleText: some View {
        Text("Oops! Something went wrong.")
            .font(.headline)
            .multilineTextAlignment(.center)
    }

    var subtitleText: some View {
        Text("We couldn’t load your health data. Please try again.")
            .font(.subheadline)
            .foregroundColor(.secondary)
            .multilineTextAlignment(.center)
    }

    var retryButton: some View {
        Button(action: retryAction) {
            HStack {
                Image(systemName: "arrow.clockwise")
                Text("Retry")
                    .fontWeight(.semibold)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .foregroundColor(.black)
            .cornerRadius(DesignSystem.Layout.medium)
        }
        .padding(.horizontal)
    }
}
