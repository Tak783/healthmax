//
//  QuizQuestionStepView.swift
//  QuizFeature
//
//  Created on 22/05/2025.
//

import CorePresentation
import CoreFoundational
import Foundation
import QuizFeature
import SwiftData
import SwiftUI

public struct QuizView: View {
    @State private var title = String.init()
    @State private var showNavigationBar = false
    @State private var shouldHideNavBar = false
    
    @ObservedObject var quizViewModel: QuizViewModel
    @Environment(\.modelContext) private var modelContext
    
    let finishQuiz: () -> Void?
    
    public init(
        quizViewModel: QuizViewModel,
        finishQuiz: @escaping () -> Void?
    ) {
        self.quizViewModel = quizViewModel
        self.finishQuiz = finishQuiz
    }
    
    public var body: some View {
        ZStack {
            DesignSystem.DSGradient.background.ignoresSafeArea()
            
            VStack(spacing: DesignSystem.Layout.medium) {
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
        .navigationBarHidden(true)
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
            loadQuiz()
        }
        .onChange(of: quizViewModel.didFinishQuiz) { _, didFinishQuiz in
            update(withDidFinishQuizStatus: didFinishQuiz)
        }
    }
}

// MARK: - Quiz View
extension QuizView {
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
            .padding(.top, -DesignSystem.Layout.medium)
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
            let biometicService = UserDefaultsSaveUserBiometricsService()
            switch biometricStepContent.biometricType {
            case .dateOfBirth:
                let dateOfBirthViewModel = DateOfBirthViewModel(
                    quizBiometricRequestContent: biometricStepContent,
                    userBiometricSevice: biometicService
                )
                QuizDOBPickerStepView(
                    quizViewModel: quizViewModel,
                    dateOfBirthViewModel: dateOfBirthViewModel
                )
            case .bloodType:
                let bloodTypeViewModel = BloodTypeViewModel(
                    quizBiometricRequestContent: biometricStepContent,
                    userBiometricSevice: biometicService
                )
                QuizBloodTypePickerView(
                    quizViewModel: quizViewModel,
                    bloodTypeViewModel: bloodTypeViewModel
                )
            case .height:
                let heightViewModel = HeightViewModel(
                    quizBiometricRequestContent: biometricStepContent,
                    userBiometricSevice: biometicService
                )
                QuizHeightPickerStepView(
                    quizViewModel: quizViewModel,
                    heightViewModel: heightViewModel
                )
            case .weight:
                let weightViewModel = WeightViewModel(
                    defaultWeight: 65,
                    quizBiometricRequestContent: biometricStepContent,
                    userBiometricSevice: biometicService
                )
                QuizWeightPickerStepView(
                    quizViewModel: quizViewModel,
                    weightViewModel: weightViewModel
                )
            
            }
        case .permission(let permissionStepContent):
            let quizPermissonStepViewModel = QuizPermissonStepViewModel(
                currentStep: currentStep,
                permissionContent: permissionStepContent
            )
            switch permissionStepContent.permissionRequestType {
            case .notifications:
                let notificationPermissionViewModel = NotificationPermissionViewModel()
                NotificationPermissionsStepView(
                    quizViewModel: quizViewModel,
                    quizPermissonStepViewModel: quizPermissonStepViewModel,
                    notificationPermissionViewModel: notificationPermissionViewModel
                )
            case .appleHealth:
                let appleHealthPermissionsViewModel = AppleHealthPermissionsViewModel()
                AppleHealthPermissonRequestStepView(
                    quizViewModel: quizViewModel,
                    quizPermissonStepViewModel: quizPermissonStepViewModel,
                    appleHealthPermissionsViewModel: appleHealthPermissionsViewModel
                )
            case .appleFitness:
                EmptyView()
            }
        }
    }
}

// MARK: - Supporting Views
extension QuizView {
    private var loadingSpinner: some View {
        VStack {
            Spacer()
            ProgressView()
            Spacer()
        }
    }
   
    private func quizProgressHeaderView(currentStep: QuizStep) -> some View {
        HStack(alignment: .center, spacing: DesignSystem.Layout.medium) {
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

// MARK: - Helpers
extension QuizView {
    private func loadQuiz() {
        Task {
            await quizViewModel.loadQuiz()
        }
    }

    private func update(withDidFinishQuizStatus didFinishQuiz: Bool) {
        guard didFinishQuiz else {
            return
        }
        finishQuiz()
    }
}
