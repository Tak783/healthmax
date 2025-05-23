//
//  QuizProgressView.swift
//  QuizFeature
//
//  Created by Tak Mazarura on 23/05/2025.
//

import CorePresentation
import CoreFoundational
import SwiftUI

struct QuizProgressView: View {
    let progress: QuizProgress
    private let minimumVisibleProgress: Double = 0.05 // 5% minimum fill for step 0
    
    var adjustedProgress: Double {
        max(progress.progress, minimumVisibleProgress)
    }
    
    var body: some View {
        HStack() {
            progressView()
            countAndStepLabels()
        }
    }
}

// MARK: - Supporting Views
extension QuizProgressView {
    private func progressView() -> some View {
        ProgressView(value: adjustedProgress)
            .accentColor(.green)
            .scaleEffect(x: 1, y: 2, anchor: .center) // Thicker bar
            .animation(.easeInOut, value: progress.progress)
    }
    
    private func countAndStepLabels() -> some View {
        HStack {
            if progress.showsStepCount {
                Text(
                    String(
                        format: "Step %d of %d",
                        progress.currentStepIndex,
                        progress.totalStepIndexes
                    )
                )
                .font(.subheadline)
                .foregroundColor(.white)
                .bold()
            }
            if progress.showsStepCount && progress.showsProgressPercentage {
                Spacer()
            }
            if progress.showsProgressPercentage {
                Text(String(format: "%d%%", Int(progress.progress * 100)))
                    .font(.subheadline)
                    .foregroundColor(.white)
            }
        }
    }
}
