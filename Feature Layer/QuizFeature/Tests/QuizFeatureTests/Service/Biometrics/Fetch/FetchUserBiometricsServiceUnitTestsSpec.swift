//
//  FetchUserBiometricsServiceUnitTestsSpec.swift
//  QuizFeature
//
//  Created by Tak Mazarura on 24/05/2025.
//

protocol FetchUserBiometricsServiceUnitTestsSpec {
    func test_getGender_returnsSavedValue() async
    func test_getBirthday_returnsSavedValue() async
    func test_getHeight_returnsSavedValue() async
    func test_getWeight_returnsSavedValue() async
}
