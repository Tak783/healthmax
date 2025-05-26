//
//  HeightViewModel.swift
//  QuizFeature
//
//  Created on 23/05/2025.
//

import Foundation
import CoreFoundational

@MainActor
public final class HeightViewModel: ObservableObject {
    @Published public var feet: Int
    @Published public var inches: Int
    @Published public var didSave = false
    
    public private(set) var userBiometricSevice: SaveUserBiometricsServiceable
    
    public let feetRange = 3...7
    public let inchesRange = 0...11
    public let quizBiometricRequestContent: QuizBiometricRequestContent
    
    public init(
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
    public func isContinueButtonVisible() -> Bool {
        true
    }
    
    public func isContinueButtonEnabled() -> Bool {
        true
    }
}

// MARK: - BiometricViewModelling
extension HeightViewModel: BiometricViewModelling {
    public func didRequestToSaveMetric() async {
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
