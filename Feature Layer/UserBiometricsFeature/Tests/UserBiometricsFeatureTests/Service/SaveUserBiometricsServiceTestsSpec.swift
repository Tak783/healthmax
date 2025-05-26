//
//  SaveUserBiometricsServiceTestsSpec.swift
//  UserBiometricsFeature
//
//  Created by Tak Mazarura on 26/05/2025.
//

protocol SaveUserBiometricsServiceTestsSpec {
    func test_saveBloodType_savesToUserDefaults() async
    func test_saveWeight_savesToUserDefaults() async
    func test_saveHeight_savesToUserDefaults() async
    func test_saveBirthday_savesToUserDefaults() async
    func test_saveGender_savesToUserDefaults() async
}
