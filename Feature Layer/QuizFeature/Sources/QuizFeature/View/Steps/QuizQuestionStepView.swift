//
//  QuizQuestionStepView.swift
//  QuizFeature
//
//  Created by Tak Mazarura on 23/05/2025.
//

import CorePresentation
import CoreFoundational
import SwiftUI

struct QuizQuestionStepView: View {
    @ObservedObject var quizViewModel: QuizViewModel
    @ObservedObject var quizQuestionStepViewModel: QuizQuestionStepViewModel
    
    var body: some View {
        VStack() {
            quizQuestionScrollView()
                .padding()
            Spacer()
            continueButtonContainer(
                question: quizQuestionStepViewModel.questionContent
            )
            .padding(.horizontal)
        }
        .onChange(of: quizQuestionStepViewModel.didAnswerQuestion) { oldDidAnswerStatus, newDidAnswerStatus in
            
        }
    }
}

// MARK: - Question View
extension QuizQuestionStepView {
    private func quizQuestionScrollView() -> some View {
        ScrollView {
            quizQuestionView(question: quizQuestionStepViewModel.questionContent)
        }
        .scrollIndicators(.hidden)
    }
    
    private func quizQuestionView(question: QuizQuestionStepContent) -> some View {
        VStack(alignment: .leading, spacing: 14) {
            quizAnswersQuestionView(question: question)
            Spacer()
            quizchoicesView(question: question)
        }
    }
    
    private func quizAnswersQuestionView(question: QuizQuestionStepContent, isSmall: Bool = false) -> some View {
        return Text(question.question)
            .font(.title)
            .foregroundColor(.white)
            .multilineTextAlignment(.leading)
    }
    
    private func quizchoicesView(question: QuizQuestionStepContent) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(question.answerGroup) { questionGroup in
                quizAnswerGroupChoicesView(questionGroup: questionGroup)
            }
        }
    }
    
    private func quizAnswerGroupChoicesView(questionGroup: QuizAnswerGroup) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            ForEach(questionGroup.choices) { choice in
                HapticImpactButton {
                        quizViewModel.processStepAction(.finishStep)
                } label: {
                    HStack {
                        Text(choice.title)
                            .foregroundColor(.black)
                            .font(.callout)
                            .multilineTextAlignment(.leading)
                        
                        Spacer()
                    }
                }
            }
        }
    }
}

// MARK: - Continue Button
extension QuizQuestionStepView {
    @ViewBuilder
    private func continueButtonContainer(question: QuizQuestionStepContent) -> some View {
        if quizQuestionStepViewModel.isContinueButtonVisible() {
            let state = StyledHapticButton.State(
                isEnabled: quizQuestionStepViewModel.isContinueButtonEnabled(),
                isVisible: quizQuestionStepViewModel.isContinueButtonVisible()
            )
            StyledHapticButton(
                title: "Continue",
                appearance: .default,
                state: state
            ) {
                quizViewModel.processStepAction(.finishStep)
            }
        } else {
            EmptyView()
        }
    }
}
