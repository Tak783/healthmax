//
//  MetricViewModel.swift
//  QuizFeature
//
//  Created by Tak Mazarura on 23/05/2025.
//

protocol BiometricViewModelling {
    var userBiometricSevice: FetchUserBiometricsServiceable { get }
    
    func didRequestToSaveMetric()
}
