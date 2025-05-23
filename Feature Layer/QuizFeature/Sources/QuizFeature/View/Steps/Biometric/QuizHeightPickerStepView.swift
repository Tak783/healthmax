//
//  HeightPickerView.swift
//  QuizFeature
//
//  Created by Tak Mazarura on 23/05/2025.
//

import CorePresentation
import SwiftUI

struct QuizHeightPickerStepView: View {
    @ObservedObject var quizViewModel: QuizViewModel
    @ObservedObject var heightViewModel: HeightViewModel
    
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

extension QuizHeightPickerStepView {
    private var questionView: some View {
        VStack(alignment: .center, spacing: 16) {
            questionLabel
            pickerView
        }
    }
    
    private var questionLabel: some View {
        Text(heightViewModel.quizBiometricRequestContent.question)
            .multilineTextAlignment(.center)
            .foregroundColor(.white)
            .font(.system(size: 36, weight: .bold))
    }
    
    @ViewBuilder
    private var continueButton: some View {
        if heightViewModel.isContinueButtonVisible() {
            let state = StyledHapticButton.State(
                isEnabled: heightViewModel.isContinueButtonEnabled(),
                isVisible: heightViewModel.isContinueButtonVisible()
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
    
    private var pickerView: some View {
        VStack(spacing: 16) {
           HStack {
               Picker("Feet", selection: $heightViewModel.feet) {
                    ForEach(heightViewModel.feetRange, id: \.self) { ft in
                        Text("\(ft) ft").tag(ft)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: 100)

               Picker("Inches", selection: $heightViewModel.inches) {
                    ForEach(heightViewModel.inchesRange, id: \.self) { inch in
                        Text("\(inch) in").tag(inch)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: 100)
            }
            .frame(height: 150)

            Text("= \(heightViewModel.formattedCentimeters) cm")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}
