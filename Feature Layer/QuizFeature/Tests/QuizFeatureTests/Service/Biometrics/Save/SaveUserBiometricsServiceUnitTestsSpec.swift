//
//  SaveUserBiometricsServiceUnitTestsSpec.swift
//  QuizFeature
//
//  Created by Tak Mazarura on 24/05/2025.
//

protocol SaveUserBiometricsServiceUnitTestsSpec {
    func test_saveGender_savesSuccessfully() async
    func test_saveBirthday_savesSuccessfully() async
    func test_saveHeight_savesSuccessfully() async
    func test_saveWeight_savesSuccessfully() async
}
