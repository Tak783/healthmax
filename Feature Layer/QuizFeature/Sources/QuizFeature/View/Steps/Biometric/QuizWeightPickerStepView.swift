//
//  WeightPickerView.swift
//  QuizFeature
//
//  Created by Tak Mazarura on 23/05/2025.
//

import CorePresentation
import SwiftUI

struct QuizWeightPickerStepView: View {
    @ObservedObject var quizViewModel: QuizViewModel
    @ObservedObject var weightViewModel: WeightViewModel

    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            questionView
            Spacer()
            continueButton
        }
        .padding()
    }
}

extension QuizWeightPickerStepView {
    private var questionView: some View {
        VStack(alignment: .center, spacing: 16) {
            questionLabel
            pickerView
        }
    }
    
    private var questionLabel: some View {
        Text(weightViewModel.quizBiometricRequestContent.question)
            .multilineTextAlignment(.center)
            .foregroundColor(.white)
            .font(.system(size: 36, weight: .bold))
    }
    
    private var pickerView: some View {
        VStack(spacing: 16) {
            Picker("Weight", selection: $weightViewModel.weight) {
                ForEach(weightViewModel.range, id: \.self) { value in
                    Text("\(value) \(weightViewModel.unit)").tag(value)
                }
            }
            .pickerStyle(.wheel)
            .frame(height: 150)
            .clipped()
        }
    }
    
    @ViewBuilder
    private var continueButton: some View {
        if weightViewModel.isContinueButtonVisible() {
            let state = StyledHapticButton.State(
                isEnabled: weightViewModel.isContinueButtonEnabled(),
                isVisible: weightViewModel.isContinueButtonVisible()
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
