//
//  QuizUpsellStepView.swift
//  QuizFeature
//
//  Created on 23/05/2025.
//

import CorePresentation
import CoreFoundational
import SwiftUI

struct QuizUpsellStepView: View {
    @ObservedObject var quizViewModel: QuizViewModel
    @ObservedObject var quizUpsellStepViewModel: QuizUpsellStepViewModel
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            rewardView
            Spacer()
            continueButton
        }
        .padding()
    }
}

// MARK: - QuizUpsellStepView
extension QuizUpsellStepView {
    private var rewardView: some View {
        VStack(alignment: .center, spacing: DesignSystem.Layout.extraLarge) {
            Text(quizUpsellStepViewModel.upsellContent.emoji)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .font(DesignSystem.DSFont.hugeEmoji())
            Text(quizUpsellStepViewModel.upsellContent.question)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .font(DesignSystem.DSFont.largeTitle())
            Text(quizUpsellStepViewModel.upsellContent.detail)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .font(DesignSystem.DSFont.headline(weight: .regular))
        }
    }

    @ViewBuilder
    private var continueButton: some View {
        if quizUpsellStepViewModel.isContinueButtonVisible() {
            HapticImpactButton {
                quizViewModel.processStepAction(.finishStep)
            } label: {
                HStack {
                    Spacer()
                    Text("Continue")
                        .foregroundColor(.white)
                        .font(DesignSystem.DSFont.subHeadline(weight: .bold))
                        .multilineTextAlignment(.center)
                    Image(systemName: "arrow.right.circle.fill")
                        .tint(.white)
                    Spacer()
                }
                .padding()
                .background(DesignSystem.DSGradient.button)
                .cornerRadius(DesignSystem.Layout.huge)
                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
            }
        } else {
            EmptyView()
        }
    }
}
