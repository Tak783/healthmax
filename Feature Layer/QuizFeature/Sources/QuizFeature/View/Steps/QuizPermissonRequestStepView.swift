//
//  QuizPermissonRequestStepView.swift
//  QuizFeature
//
//  Created by Tak Mazarura on 23/05/2025.
//

import CorePresentation
import CoreFoundational
import SwiftUI

struct QuizPermissonRequestStepView: View {
    @ObservedObject var quizViewModel: QuizViewModel
    @ObservedObject var quizPermissonStepViewModel: QuizPermissonStepViewModel
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            infoView()
            Spacer()
            continueButton()
        }
        .padding()
    }
}

extension QuizPermissonRequestStepView {
    private func infoView() -> some View {
        VStack(alignment: .center, spacing: 16) {
            imageView
            Text(quizPermissonStepViewModel.permissionContent.question)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .font(.largeTitle)
            Text(quizPermissonStepViewModel.permissionContent.detail)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.white)
                .font(.headline)
        }
    }
    
    @ViewBuilder
    private var imageView: some View {
        let image = quizPermissonStepViewModel.permissionContent.image
        switch image.type {
        case .system:
            Image(systemName: image.name)
        case .emoji:
            Text(image.name)
        case .asset:
            Image(image.name)
        }
    }
    
    @ViewBuilder
    private func continueButton() -> some View {
        let state = StyledHapticButton.State(
            isEnabled: quizPermissonStepViewModel.isContinueButtonEnabled(),
            isVisible: quizPermissonStepViewModel.isContinueButtonVisible()
        )
        StyledHapticButton(
            title: "Continue",
            appearance: StyledHapticButton.Appearance.default,
            state: state
        ) {
            quizViewModel.processStepAction(.finishStep)
        }
    }
}
