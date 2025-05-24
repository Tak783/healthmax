//
//  SaveUserBiometricsServiceable.swift
//  QuizFeature
//
//  Created by Tak Mazarura on 24/05/2025.
//

import Foundation

protocol SaveUserBiometricsServiceable: Sendable {
    func saveGender(_ gender: String) async -> Result<Void, Error>
    func saveBirthday(_ age: Date) async -> Result<Void, Error>
    func saveHeight(_ height: Double) async -> Result<Void, Error>
    func saveWeight(_ weight: Int) async -> Result<Void, Error>
}
