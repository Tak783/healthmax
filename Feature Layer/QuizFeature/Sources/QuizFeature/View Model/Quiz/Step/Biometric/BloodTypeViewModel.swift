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
final class BloodTypeViewModel: ObservableObject {
    @Published var bloodType: BloodType
    @Published var didSave = false
    
    private(set) var userBiometricSevice: SaveUserBiometricsServiceable
 
    let quizBiometricRequestContent: QuizBiometricRequestContent
    
    init(
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
    func isContinueButtonVisible() -> Bool {
        true
    }
    
    func isContinueButtonEnabled() -> Bool {
        true
    }
}

// MARK: - BiometricViewModelling
extension BloodTypeViewModel: BiometricViewModelling {
    func didRequestToSaveMetric() async {
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
