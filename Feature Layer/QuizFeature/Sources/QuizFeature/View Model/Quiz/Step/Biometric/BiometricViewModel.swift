//
//  MetricViewModel.swift
//  QuizFeature
//
//  Created by Tak Mazarura on 23/05/2025.
//

@MainActor
protocol BiometricViewModelling {
    var userBiometricSevice: SaveUserBiometricsServiceable { get }
    
    func didRequestToSaveMetric() async
}
