//
//  DateOfBirthPickerView.swift
//  QuizFeature
//
//  Created by Tak Mazarura on 23/05/2025.
//

import CorePresentation
import SwiftUI

struct DateOfBirthPickerView: View {
    @ObservedObject var quizViewModel: QuizViewModel
    @ObservedObject var dateOfBirthViewModel: DateOfBirthViewModel

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

// MARK: - Question Picker
extension DateOfBirthPickerView {
    private var questionView: some View {
        VStack(alignment: .center, spacing: 16) {
            questionLabel
            pickerView
        }
    }
    
    private var questionLabel: some View {
        Text(dateOfBirthViewModel.quizBiometricRequestContent.question)
            .multilineTextAlignment(.center)
            .foregroundColor(.white)
            .font(.system(size: 36, weight: .bold))
    }
    
    private var pickerView: some View {
        DatePicker(
            "Date of Birth",
            selection: $dateOfBirthViewModel.dateOfBirth,
            in: dateOfBirthViewModel.oldestSelectableDate...Date(),
            displayedComponents: [.date]
        )
    }
    
    @ViewBuilder
    private var continueButton: some View {
        if dateOfBirthViewModel.isContinueButtonVisible() {
            let state = StyledHapticButton.State(
                isEnabled: dateOfBirthViewModel.isContinueButtonEnabled(),
                isVisible: dateOfBirthViewModel.isContinueButtonVisible()
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
