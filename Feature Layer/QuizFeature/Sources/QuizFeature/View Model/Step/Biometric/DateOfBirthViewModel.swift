//
//  DateOfBirthViewModel.swift
//  QuizFeature
//
//  Created by Tak Mazarura on 23/05/2025.
//

import Foundation

final class DateOfBirthViewModel: ObservableObject {
    @Published var dateOfBirth: Date
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
        quizBiometricRequestContent: QuizBiometricRequestContent
    ) {
        self.dateOfBirth = defaultDOB
        self.oldestSelectableDate = oldestSelectableDate
        self.quizBiometricRequestContent = quizBiometricRequestContent
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
    func didRequestToSaveMetric() {
        print("Saving Date of Birth: \(dateOfBirth)")
    }
}
