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
        contentView
            .onChange(of: heightViewModel.didSave) { oldValue, newValue in
                quizViewModel.processStepAction(.finishStep)
            }
    }
}

// MARK: - Main View
extension QuizHeightPickerStepView {
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
extension QuizHeightPickerStepView {
    private var questionLabel: some View {
        HStack {
            Text(heightViewModel.quizBiometricRequestContent.question)
                .font(DesignSystem.DSFont.title(weight: .bold))
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
                .padding()
            Spacer()
        }
    }
    
    private var pickerView: some View {
        VStack {
           HStack {
               Picker("Feet", selection: $heightViewModel.feet) {
                    ForEach(heightViewModel.feetRange, id: \.self) { ft in
                        Text("\(ft) ft").tag(ft)
                    }
                }
                .pickerStyle(.wheel)
                .disableTabViewSwipeGesture(false)
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
        }
    }
    
    @ViewBuilder
    private var continueButton: some View {
        HStack(alignment: .center) {
            HapticImpactButton {
                Task {
                    await heightViewModel.didRequestToSaveMetric()
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
