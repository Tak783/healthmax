//
//  QuizQuestionStepView.swift
//  QuizFeature
//
//  Created by Tak Mazarura on 22/05/2025.
//

import CorePresentation
import CoreFoundational
import Foundation
import SwiftData
import SwiftUI

public struct QuizView: View {
    @State private var title = String.init()
    @State private var showNavigationBar = false
    @State private var shouldHideNavBar = false
    
    @ObservedObject var quizViewModel: QuizViewModel
    @Environment(\.modelContext) private var modelContext
    
    let finishQuiz: () -> Void?
    let didTapNavigationBarBackButton: () -> Void?
    
    public init(
        quizViewModel: QuizViewModel,
        finishQuiz: @escaping () -> Void?,
        didTapNavigationBarBackButton: @escaping () -> Void?
    ) {
        self.quizViewModel = quizViewModel
        self.finishQuiz = finishQuiz
        self.didTapNavigationBarBackButton = didTapNavigationBarBackButton
    }
    
    public var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 12) {
                if quizViewModel.isLoading {
                    loadingSpinner
                } else {
                    if
                        let quizSessionModel = quizViewModel.quizSessionModel,
                        let currentStep = quizViewModel.currentStep()
                    {
                        quizProgressHeaderView(
                            currentStep: currentStep
                        )
                        .padding(.horizontal)
                        .padding(.top)
                        
                        quizStepView(
                            quizSessionModel: quizSessionModel,
                            currentStep: currentStep
                        )
                        .padding(.horizontal)
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .navigationBarHidden(shouldHideNavBar)
        .toolbar {
            if let title = quizViewModel.currentStep()?.title {
                ToolbarItem(placement: .principal) {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.white)
                }
            }
        }
        .onAppear {
            quizViewModel.loadQuiz()
        }
        .onChange(of: quizViewModel.didFinishQuiz) { _, didFinishQuiz in
            update(withDidFinishQuizStatus: didFinishQuiz)
        }
        .onChange(of: quizViewModel.stepIndex) { _, newIndex in
            updateToShowNavigationBar()
        }
    }
   
    /// A delay is needed becuase bar visibility mid-navigation or mid-tab transition can
    ///     cause SwiftUI to skip animations or perform glitchy transitions, especially inside NavigationStack or TabView.
    private func updateToShowNavigationBar() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            shouldHideNavBar = quizViewModel.currentStep()?.title == nil
        }
    }
}

// MARK: - Quiz View
extension QuizView {
    @ToolbarContentBuilder
    private var navBarTitleView: some ToolbarContent {
        if let title = quizViewModel.currentStep()?.title {
            ToolbarItem(placement: .principal) {
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.green)
            }
        }
    }

    private func quizStepView(
        quizSessionModel: QuizSessionModel,
        currentStep: QuizStep
    ) -> some View {
        TabView(selection: $quizViewModel.stepIndex) {
            ForEach(quizSessionModel.quiz.steps.indices, id: \.self) { index in
                quizStepView(
                    quizViewModel: quizViewModel,
                    currentStep: currentStep,
                    quizSessionModel: quizSessionModel
                ).tag(index)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .animation(.easeInOut, value: quizViewModel.stepIndex)
        .disableTabViewSwipeGesture(true)
    }
    
    @ViewBuilder
    private func quizStepView(
        quizViewModel: QuizViewModel,
        currentStep: QuizStep,
        quizSessionModel: QuizSessionModel
    ) -> some View {
        switch quizSessionModel.currentStep.content {
        case .question(let quizQuestionStepContent):
            let currentAnswer = quizSessionModel.answer(forQuestionID: currentStep.id)
            let quizQuestionStepViewModel = QuizQuestionStepViewModel(
                currentStep: currentStep,
                questionContent: quizQuestionStepContent,
                answer: currentAnswer
            )
            QuizQuestionStepView(
                quizViewModel: quizViewModel,
                quizQuestionStepViewModel: quizQuestionStepViewModel
            )
            .padding(.top, -12)
        case .upsell(let quizUpsellStepContent):
            let quizQuestionStepViewModel = QuizUpsellStepViewModel(
                currentStep: currentStep,
                upsellContent: quizUpsellStepContent
            )
            QuizUpsellStepView(
                quizViewModel: quizViewModel,
                quizUpsellStepViewModel: quizQuestionStepViewModel
            )
        case .biometric(let biometricStepContent):
            switch biometricStepContent.biometricType {
            case .height:
                let heightViewModel = HeightViewModel(
                    quizBiometricRequestContent: biometricStepContent
                )
                QuizHeightPickerStepView(
                    quizViewModel: quizViewModel,
                    heightViewModel: heightViewModel
                )
            case .weight:
                let weightViewModel = WeightViewModel(
                    defaultWeight: 65,
                    quizBiometricRequestContent: biometricStepContent
                )
                QuizWeightPickerStepView(
                    quizViewModel: quizViewModel,
                    weightViewModel: weightViewModel
                )
            case .dateOfBirth:
                let dateOfBirthViewModel = DateOfBirthViewModel(
                    quizBiometricRequestContent: biometricStepContent
                )
                QuizDOBPickerStepView(
                    quizViewModel: quizViewModel,
                    dateOfBirthViewModel: dateOfBirthViewModel
                )
            }
        case .permission(_):
            EmptyView()
        }
    }
}

// MARK: - Supporting Views
extension QuizView {
    var loadingSpinner: some View {
        VStack {
            Spacer()
            ProgressView()
            Spacer()
        }
    }
    
   
    private func quizProgressHeaderView(currentStep: QuizStep) -> some View {
        HStack(alignment: .center, spacing: 12) {
            if currentStep.showProgressBar {
                quizProgressView()
            } else {
                Spacer()
            }
        }.padding(.horizontal)
    }
    
    @ViewBuilder
    private func quizProgressView() -> some View {
        if let quizSessionModel = quizViewModel.quizSessionModel {
            QuizProgressView(
                progress: quizSessionModel.quizProgress
            )
        } else {
            EmptyView()
        }
    }
}

// MARK: - Update View
extension QuizView {
    func update(withDidFinishQuizStatus didFinishQuiz: Bool) {
        guard didFinishQuiz else {
            return
        }
        finishQuiz()
    }
}
