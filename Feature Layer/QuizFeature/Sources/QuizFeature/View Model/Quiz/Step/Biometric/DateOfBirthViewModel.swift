//
//  DateOfBirthViewModel.swift
//  QuizFeature
//
//  Created on 23/05/2025.
//

import CoreFoundational
import Foundation

@MainActor
public final class DateOfBirthViewModel: ObservableObject {
    @Published public var dateOfBirth: Date
    @Published public var didSave = false
    
    public let userBiometricSevice: SaveUserBiometricsServiceable
   
    public let oldestSelectableDate: Date
    public let quizBiometricRequestContent: QuizBiometricRequestContent
    
    public static let defaultDateOfBirth = Calendar.current.date(
        byAdding: .year,
        value: -14,
        to: Date()
    )!
    
    public static let oldestSelectableDateOfBirth = Calendar.current.date(
        byAdding: .year,
        value: -120,
        to: Date()
    )!
    
    public init(
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
    public func isContinueButtonVisible() -> Bool {
        true
    }
    
    public func isContinueButtonEnabled() -> Bool {
        true
    }
}

// MARK: - BiometricViewModelling
extension DateOfBirthViewModel: BiometricViewModelling {
    public func didRequestToSaveMetric() async {
        let result = await userBiometricSevice.saveBirthday(dateOfBirth)
        switch result {
        case .success:
            safePrint("✅ Date of Birth: \(dateOfBirth)")
            didSave = true
        case .failure(let error):
            safePrint("⛔️ Failed to saved Date of Birth with error: \(error.localizedDescription)")
        }
    }
}
