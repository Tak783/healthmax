//
//  BloodTypeViewModel.swift
//  QuizFeature
//
//  Created by Tak Mazarura on 25/05/2025.
//

import CoreHealthMaxModels
import CoreSharedModels
import CoreFoundational
import SwiftUI

@MainActor
public final class BloodTypeViewModel: ObservableObject {
    @Published public var bloodType: BloodType
    @Published public var didSave = false
    
    public private(set) var userBiometricSevice: SaveUserBiometricsServiceable
 
    public let quizBiometricRequestContent: QuizBiometricRequestContent
    
    public init(
        bloodType: BloodType = .aPositive,
        quizBiometricRequestContent: QuizBiometricRequestContent,
        userBiometricSevice: SaveUserBiometricsServiceable
    ) {
        self.bloodType = bloodType
        self.quizBiometricRequestContent = quizBiometricRequestContent
        self.userBiometricSevice = userBiometricSevice
    }
}

// MARK: - QuizStepViewModellable
extension BloodTypeViewModel: QuizStepViewModellable {
    public func isContinueButtonVisible() -> Bool {
        true
    }
    
    public func isContinueButtonEnabled() -> Bool {
        true
    }
}

// MARK: - BiometricViewModelling
extension BloodTypeViewModel: BiometricViewModelling {
    public func didRequestToSaveMetric() async {
        let result = await userBiometricSevice.saveBloodType(bloodType.displayName)
        switch result {
        case .success:
            safePrint("✅ Saved Blood Type: \(bloodType.displayName)")
            didSave = true
        case .failure(let error):
            safePrint("⛔️ Failed to save Blood Type with error: \(error.localizedDescription)")
        }
    }
}
