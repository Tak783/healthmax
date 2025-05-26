//
//  QuizPermissonStepViewModel.swift
//  QuizFeature
//
//  Created on 23/05/2025.
//

import Foundation

@MainActor
public final class QuizPermissonStepViewModel: ObservableObject {
    public private(set) var currentStep: QuizStep
    public private(set) var permissionContent: QuizPermissionRequestContent
    
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
    public func isContinueButtonVisible() -> Bool {
        true
    }
    
    public func isContinueButtonEnabled() -> Bool {
        true
    }
}
