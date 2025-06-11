//
//  SimpleRecommendationsViewModellable.swift
//  UserBiometricsFeature
//
//  Created by Tak Mazarura on 11/06/2025.
//

import Foundation

@MainActor
protocol SimpleRecommendationsViewModellable {
    var recommendationPresentationModels: [SimpleRecommendationPresentationModel] { get }
    
    func load() async
}
 
