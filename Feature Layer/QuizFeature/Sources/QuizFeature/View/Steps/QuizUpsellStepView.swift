//
//  QuizUpsellStepView.swift
//  QuizFeature
//
//  Created by Tak Mazarura on 23/05/2025.
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
            rewardView()
            Spacer()
            continueButton()
        }
        .padding()
    }
}

// MARK: - QuizUpsellStepView
extension QuizUpsellStepView {
    private func rewardView() -> some View {
        VStack(alignment: .center, spacing: 16) {
            Text(quizUpsellStepViewModel.upsellContent.emoji)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .font(.system(size: 36, weight: .bold))
            Text(quizUpsellStepViewModel.upsellContent.question)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .font(.largeTitle)
            Text(quizUpsellStepViewModel.upsellContent.detail)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.white)
                .font(.headline)
        }
    }

    @ViewBuilder
    private func continueButton() -> some View {
        if quizUpsellStepViewModel.isContinueButtonVisible() {
            let state = StyledHapticButton.State(
                isEnabled: quizUpsellStepViewModel.isContinueButtonEnabled(),
                isVisible: quizUpsellStepViewModel.isContinueButtonVisible()
            )
            StyledHapticButton(
                title: "Continue",
                appearance: StyledHapticButton.Appearance.default,
                state: state
            ) {
                quizViewModel.processStepAction(.finishStep)
            }
        } else {
            EmptyView()
        }
    }
}
