//
//  QuizDOBPickerStepView.swift
//  QuizFeature
//
//  Created on 23/05/2025.
//

import CorePresentation
import QuizFeature
import SwiftUI

struct QuizDOBPickerStepView: View {
    @ObservedObject var quizViewModel: QuizViewModel
    @ObservedObject var dateOfBirthViewModel: DateOfBirthViewModel

    var body: some View {
        contentView
            .onChange(of: dateOfBirthViewModel.didSave) { oldValue, newValue in
                quizViewModel.processStepAction(.finishStep)
            }
    }
}

// MARK: - Main View
extension QuizDOBPickerStepView {
    private var contentView: some View {
        VStack{
            questionLabel
            Spacer()
            VStack(spacing: 16) {
                pickerView
                continueButton
            }
        }
    }
}

// MARK: - Supporting Views
extension QuizDOBPickerStepView {
    private var questionLabel: some View {
        HStack {
            Text(dateOfBirthViewModel.quizBiometricRequestContent.question)
                .font(DesignSystem.DSFont.title(weight: .bold))
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
                .padding(.horizontal)
                .padding(.top, DesignSystem.Layout.extraLarge)
            Spacer()
        }
    }
    
    private var pickerView: some View {
        DatePicker(
            "",
            selection: $dateOfBirthViewModel.dateOfBirth,
            in: dateOfBirthViewModel.oldestSelectableDate...Date(),
            displayedComponents: [.date]
        )
        .datePickerStyle(.graphical)
        .disableTabViewSwipeGesture(false)
        .labelsHidden()
        .padding(.horizontal, DesignSystem.Layout.medium)
    }
    
    @ViewBuilder
    private var continueButton: some View {
        VStack {
            HStack(alignment: .center) {
                HapticImpactButton {
                    Task {
                        await dateOfBirthViewModel.didRequestToSaveMetric()
                    }
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
            }
        }
    }
}
