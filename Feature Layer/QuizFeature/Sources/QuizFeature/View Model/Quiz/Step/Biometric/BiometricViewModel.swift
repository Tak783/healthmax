//
//  MetricViewModel.swift
//  QuizFeature
//
//  Created on 23/05/2025.
//

@MainActor
protocol BiometricViewModelling {
    var userBiometricSevice: SaveUserBiometricsServiceable { get }
    
    func didRequestToSaveMetric() async
}
