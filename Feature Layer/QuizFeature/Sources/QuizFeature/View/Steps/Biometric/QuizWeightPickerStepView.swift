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
        contentView
            .onChange(of: weightViewModel.didSave) { oldValue, newValue in
                quizViewModel.processStepAction(.finishStep)
            }
    }
}

// MARK: - Main View
extension QuizWeightPickerStepView {
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
extension QuizWeightPickerStepView {
    private var questionLabel: some View {
        HStack {
            Text(weightViewModel.quizBiometricRequestContent.question)
                .font(DesignSystem.DSFont.title(weight: .bold))
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
                .padding(.top, DesignSystem.Layout.extraLarge)
            Spacer()
        }
        .padding(.horizontal)
    }
    
    private var pickerView: some View {
        VStack {
            Picker("Weight", selection: $weightViewModel.weight) {
                ForEach(weightViewModel.range, id: \.self) { value in
                    Text("\(value) \(weightViewModel.unit)").tag(value)
                }
            }
            .pickerStyle(.wheel)
            .disableTabViewSwipeGesture(false)
        }
    }
    
    @ViewBuilder
    private var continueButton: some View {
        HStack(alignment: .center) {
            HapticImpactButton {
                Task {
                    await weightViewModel.didRequestToSaveMetric()
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
