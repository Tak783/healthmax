//
//  WeightViewModel.swift
//  QuizFeature
//
//  Created by Tak Mazarura on 23/05/2025.
//

import Foundation

final class WeightViewModel: ObservableObject {
    @Published var weight: Int
    let range: ClosedRange<Int>
    let unit: String
    let quizBiometricRequestContent: QuizBiometricRequestContent
    
    init(
        defaultWeight: Int = 70,
        range: ClosedRange<Int> = 20...200,
        unit: String = "kg",
        quizBiometricRequestContent: QuizBiometricRequestContent
    ) {
        self.weight = defaultWeight
        self.range = range
        self.unit = unit
        self.quizBiometricRequestContent = quizBiometricRequestContent
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
    func didRequestToSaveMetric() {
        // Save logic for weight
        print("Saving Weight: \(weight) kg")
    }
}
