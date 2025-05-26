//
//  WeightViewModel.swift
//  QuizFeature
//
//  Created on 23/05/2025.
//

import CoreFoundational
import Foundation
import UserBiometricsFeature

@MainActor
public final class WeightViewModel: ObservableObject {
    @Published public var weight: Int
    @Published public var didSave = false
    
    public let userBiometricSevice: SaveUserBiometricsServiceable
    
    public let range: ClosedRange<Int>
    public let unit: String
    public let quizBiometricRequestContent: QuizBiometricRequestContent
    
    public init(
        defaultWeight: Int = 70,
        range: ClosedRange<Int> = 20...200,
        unit: String = "kg",
        quizBiometricRequestContent: QuizBiometricRequestContent,
        userBiometricSevice: SaveUserBiometricsServiceable
    ) {
        self.weight = defaultWeight
        self.range = range
        self.unit = unit
        self.quizBiometricRequestContent = quizBiometricRequestContent
        self.userBiometricSevice = userBiometricSevice
    }
}

// MARK: - QuizStepViewModellable
extension WeightViewModel: QuizStepViewModellable {
    public func isContinueButtonVisible() -> Bool {
        true
    }
    
    public func isContinueButtonEnabled() -> Bool {
        true
    }
}

// MARK: - BiometricViewModelling
extension WeightViewModel: BiometricViewModelling {
    public func didRequestToSaveMetric() async {
        let result = await userBiometricSevice.saveWeight(weight)
        switch result {
        case .success:
            safePrint("✅ Saved Weight: \(weight)")
            didSave = true
        case .failure(let error):
            safePrint("⛔️ Failed to save Weight: \(weight) kg with error: \(error.localizedDescription)")
        }
    }
}
