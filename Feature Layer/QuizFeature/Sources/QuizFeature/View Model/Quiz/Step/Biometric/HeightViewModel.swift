//
//  HeightViewModel.swift
//  QuizFeature
//
//  Created on 23/05/2025.
//

import Foundation
import CoreFoundational

@MainActor
final class HeightViewModel: ObservableObject {
    @Published var feet: Int
    @Published var inches: Int
    @Published var didSave = false
    
    private(set) var userBiometricSevice: SaveUserBiometricsServiceable
    
    let feetRange = 3...7
    let inchesRange = 0...11

    let quizBiometricRequestContent: QuizBiometricRequestContent
    
    init(
        defaultFeet: Int = 5,
        defaultInches: Int = 7,
        quizBiometricRequestContent: QuizBiometricRequestContent,
        userBiometricSevice: SaveUserBiometricsServiceable
    ) {
        self.feet = defaultFeet
        self.inches = defaultInches
        self.quizBiometricRequestContent = quizBiometricRequestContent
        self.userBiometricSevice = userBiometricSevice
    }
}

// MARK: - QuizStepViewModellable
extension HeightViewModel: QuizStepViewModellable {
    func isContinueButtonVisible() -> Bool {
        true
    }
    
    func isContinueButtonEnabled() -> Bool {
        true
    }
}

// MARK: - BiometricViewModelling
extension HeightViewModel: BiometricViewModelling {
    func didRequestToSaveMetric() async {
        let combinedHeightInFeet = Double.combinedHeightInFeet(feet: feet, inches: inches)
        let result = await userBiometricSevice.saveHeight(combinedHeightInFeet)
        switch result {
        case .success:
            safePrint("✅ Saved Blood Type: \(feet)ft \(inches)")
            didSave = true
        case .failure(let error):
            safePrint("⛔️ Failed to save Blood Type with error: \(error.localizedDescription)")
        }
    }
}
