//
//  MetricViewModel.swift
//  QuizFeature
//
//  Created on 23/05/2025.
//

import UserBiometricsFeature

@MainActor
public protocol BiometricViewModelling {
    var userBiometricSevice: SaveUserBiometricsServiceable { get }
    
    func didRequestToSaveMetric() async
}
