//
//  HeightViewModel.swift
//  QuizFeature
//
//  Created by Tak Mazarura on 23/05/2025.
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
    
    /// Decimal representation like 5.91 for 5 ft 11 in (not mathematically correct, just visual)
    var heightAsDecimalString: String {
        String(format: "%.2f", Double(feet) + (Double(inches) / 100))
    }
    
    /// Correct mathematical decimal (e.g., 5.9166 for 5 ft 11 in)
    var heightInFeetDecimal: Double {
        Double(feet) + (Double(inches) / 12.0)
    }
    
    var formattedCentimeters: String {
        let totalInches = (feet * 12) + inches
        let cm = Double(totalInches) * 2.54
        return String(format: "%.1f", cm)
    }
    
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
        let result = await userBiometricSevice.saveHeight(heightInFeetDecimal)
        switch result {
        case .success:
            efficientPrint("✅ Saved Height: \(feet)ft \(inches)")
            didSave = true
        case .failure(let error):
            efficientPrint("⛔️ Failed to save Height with error \(error.localizedDescription)")
        }
    }
}
