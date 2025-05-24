//
//  QuizPermissonStepViewModel.swift
//  QuizFeature
//
//  Created on 23/05/2025.
//

import Foundation

@MainActor
final class QuizPermissonStepViewModel: ObservableObject {
    private(set) var currentStep: QuizStep
    private(set) var permissionContent: QuizPermissionRequestContent
    
    public init(
        currentStep: QuizStep,
        permissionContent: QuizPermissionRequestContent
    ) {
        self.currentStep = currentStep
        self.permissionContent = permissionContent
    }
}

// MARK: - QuizStepViewModellable
extension QuizPermissonStepViewModel: QuizStepViewModellable {
    func isContinueButtonVisible() -> Bool {
        true
    }
    
    func isContinueButtonEnabled() -> Bool {
        true
    }
}
