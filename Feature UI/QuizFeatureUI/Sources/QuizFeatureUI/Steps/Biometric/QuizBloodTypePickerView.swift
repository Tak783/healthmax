//
//  QuizBloodTypePickerView.swift
//  QuizFeature
//
//  Created by Tak Mazarura on 25/05/2025.
//

import CorePresentation
import QuizFeature
import SwiftUI

struct QuizBloodTypePickerView: View {
    @ObservedObject var quizViewModel: QuizViewModel
    @ObservedObject var bloodTypeViewModel: BloodTypeViewModel

    var body: some View {
        contentView
            .onChange(of: bloodTypeViewModel.didSave) { oldValue, newValue in
                quizViewModel.processStepAction(.finishStep)
            }
    }
}

// MARK: - Main View
extension QuizBloodTypePickerView {
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
extension QuizBloodTypePickerView {
    private var questionLabel: some View {
        HStack {
            Text(bloodTypeViewModel.quizBiometricRequestContent.question)
                .font(DesignSystem.DSFont.title(weight: .bold))
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
                .padding(.horizontal)
                .padding(.top, DesignSystem.Layout.extraLarge)
            Spacer()
        }
    }
    
    private var pickerView: some View {
        BloodTypePickerView(selectedBloodType: $bloodTypeViewModel.bloodType)
    }
    
    @ViewBuilder
    private var continueButton: some View {
        VStack {
            HStack(alignment: .center) {
                HapticImpactButton {
                    Task {
                        await bloodTypeViewModel.didRequestToSaveMetric()
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
