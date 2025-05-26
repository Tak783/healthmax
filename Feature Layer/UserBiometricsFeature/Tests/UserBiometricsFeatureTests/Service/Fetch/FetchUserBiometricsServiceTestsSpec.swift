//
//  FetchUserBiometricsServiceTestsSpec.swift
//  UserBiometricsFeature
//
//  Created by Tak Mazarura on 26/05/2025.
//

protocol FetchUserBiometricsServiceTestsSpec {
    func test_getGender_returnsStoredValue() async
    func test_getBirthday_returnsStoredValue() async
    func test_getHeight_returnsStoredValue() async
    func test_getWeight_returnsStoredValue() async
    func test_getBloodType_returnsStoredValue() async
    func test_fetchAllMetrics_returnsAllNonNilMetrics() async
    func test_fetchAllMetrics_returnsFailureWhenAllAreMissing() async
}
