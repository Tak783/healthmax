//
//  DateOfBirthViewModel.swift
//  QuizFeature
//
//  Created by Tak Mazarura on 23/05/2025.
//

import CoreFoundational
import Foundation

@MainActor
final class DateOfBirthViewModel: ObservableObject {
    @Published var dateOfBirth: Date
    @Published var didSave = false
    
    private(set) var userBiometricSevice: SaveUserBiometricsServiceable
   
    let oldestSelectableDate: Date
    let quizBiometricRequestContent: QuizBiometricRequestContent
    
    static let defaultDateOfBirth = Calendar.current.date(
        byAdding: .year,
        value: -14,
        to: Date()
    )!
    
    static let oldestSelectableDateOfBirth = Calendar.current.date(
        byAdding: .year,
        value: -120,
        to: Date()
    )!
    
    init(
        defaultDOB: Date = DateOfBirthViewModel.defaultDateOfBirth,
        oldestSelectableDate: Date = DateOfBirthViewModel.oldestSelectableDateOfBirth,
        quizBiometricRequestContent: QuizBiometricRequestContent,
        userBiometricSevice: SaveUserBiometricsServiceable
    ) {
        self.dateOfBirth = defaultDOB
        self.oldestSelectableDate = oldestSelectableDate
        self.quizBiometricRequestContent = quizBiometricRequestContent
        self.userBiometricSevice = userBiometricSevice
    }
}

// MARK: - QuizStepViewModellable
extension DateOfBirthViewModel: QuizStepViewModellable {
    func isContinueButtonVisible() -> Bool {
        true
    }
    
    func isContinueButtonEnabled() -> Bool {
        true
    }
}

// MARK: - BiometricViewModelling
extension DateOfBirthViewModel: BiometricViewModelling {
    func didRequestToSaveMetric() async {
        let result = await userBiometricSevice.saveBirthday(dateOfBirth)
        switch result {
        case .success:
            efficientPrint("✅ Date of Birth: \(dateOfBirth)")
            didSave = true
        case .failure(let error):
            efficientPrint("⛔️ Failed to saved Date of Birth with error \(error.localizedDescription)")
        }
    }
}
