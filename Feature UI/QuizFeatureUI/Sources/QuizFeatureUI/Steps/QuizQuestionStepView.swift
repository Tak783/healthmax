//
//  QuizQuestionStepView.swift
//  QuizFeature
//
//  Created on 23/05/2025.
//

import CorePresentation
import CoreFoundational
import QuizFeature
import SwiftUI

struct QuizQuestionStepView: View {
    @ObservedObject var quizViewModel: QuizViewModel
    @ObservedObject var quizQuestionStepViewModel: QuizQuestionStepViewModel
    
    var body: some View {
        VStack() {
            questionView(question: quizQuestionStepViewModel.questionContent)
            Spacer()
            answersSection(question: quizQuestionStepViewModel.questionContent)
        }
        .onChange(of: quizQuestionStepViewModel.didAnswerQuestion) { oldDidAnswerStatus, newDidAnswerStatus in
            if newDidAnswerStatus == true {
                quizViewModel.recordAnswer(quizQuestionStepViewModel.answer)
            }
        }
    }
}

// MARK: - Question View
extension QuizQuestionStepView {
    private func questionView(
        question: QuizQuestionStepContent
    ) -> some View {
        HStack {
            Text(question.question)
                .font(DesignSystem.DSFont.title(weight: .bold))
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
                .padding(.horizontal)
                .padding(.top, DesignSystem.Layout.extraExtraLarge)
            Spacer()
        }
    }
    
    private func answersSection(question: QuizQuestionStepContent) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Spacer()
            ForEach(question.answerGroup) { questionGroup in
                quizAnswerGroupChoicesView(questionGroup: questionGroup)
            }
        }
    }
    
    private func quizAnswerGroupChoicesView(questionGroup: QuizAnswerGroup) -> some View {
        VStack(alignment: .leading, spacing: DesignSystem.Layout.medium) {
            ForEach(questionGroup.choices) { choice in
                HapticImpactButton {
                    quizQuestionStepViewModel.didSelectAnswerChoice(choice)
                    quizViewModel.processStepAction(.finishStep)
                } label: {
                    HStack {
                        Text(choice.title)
                            .foregroundColor(.black)
                            .font(DesignSystem.DSFont.subHeadline(weight: .semibold))
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.vertical, DesignSystem.Layout.extraLarge)
                    .background(Color.white)
                    .cornerRadius(DesignSystem.Layout.medium)
                    .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                }
            }
        }
        .padding(.bottom)
    }
}
