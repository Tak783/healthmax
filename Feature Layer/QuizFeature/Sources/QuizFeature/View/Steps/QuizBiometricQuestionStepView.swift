//
//  QuizBiometricQuestionStepView.swift
//  QuizFeature
//
//  Created by Tak Mazarura on 23/05/2025.
//

import CorePresentation
import CoreFoundational
import SwiftUI

struct QuizBiometricQuestionStepView: View {
    @ObservedObject var quizViewModel: QuizViewModel
    @ObservedObject var biometricStepViewModel: QuizBiometricQuestionStepViewModel
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            questionView()
            Spacer()
            continueButton()
        }
        .padding()
    }
}

extension QuizBiometricQuestionStepView {
    private func questionView() -> some View {
        VStack(alignment: .center, spacing: 16) {
            Text(biometricStepViewModel.biometricContent.question)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .font(.system(size: 36, weight: .bold))
        }
    }

    @ViewBuilder
    private func continueButton() -> some View {
        if biometricStepViewModel.isContinueButtonVisible() {
            let state = StyledHapticButton.State(
                isEnabled: biometricStepViewModel.isContinueButtonEnabled(),
                isVisible: biometricStepViewModel.isContinueButtonVisible()
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
