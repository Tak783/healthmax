//
//  WeightViewModel.swift
//  QuizFeature
//
//  Created by Tak Mazarura on 23/05/2025.
//

import CoreFoundational
import Foundation

@MainActor
final class WeightViewModel: ObservableObject {
    @Published var weight: Int
    @Published var didSave = false
    
    private(set) var userBiometricSevice: SaveUserBiometricsServiceable
    
    let range: ClosedRange<Int>
    let unit: String
    let quizBiometricRequestContent: QuizBiometricRequestContent
    
    init(
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
    func isContinueButtonVisible() -> Bool {
        true
    }
    
    func isContinueButtonEnabled() -> Bool {
        true
    }
}

// MARK: - BiometricViewModelling
extension WeightViewModel: BiometricViewModelling {
    func didRequestToSaveMetric() async {
        let result = await userBiometricSevice.saveWeight(weight)
        switch result {
        case .success:
            efficientPrint("✅ Saved Weight: \(weight)")
            didSave = true
        case .failure(let error):
            efficientPrint("⛔️ Failed to save Weight: \(weight) kg with error \(error.localizedDescription)")
        }
    }
}
