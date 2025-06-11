//
//  SimpleRecommendationsViewModel.swift
//  UserBiometricsFeature
//
//  Created by Tak Mazarura on 11/06/2025.
//

import Foundation
import CoreFoundational
import CoreHealthKit
import CoreHealthMaxModels
import CorePresentation

@MainActor
protocol SimpleRecommendationsViewModellable {
    var recommendationPresentationModels: [SimpleRecommendationPresentationModellabe] { get }
    func load() async
}

@MainActor
public final class SimpleRecommendationsViewModel: ObservableObject {
    @Published public var isLoading = true
    @Published public var recommendationPresentationModels = [SimpleRecommendationPresentationModellabe]()
    @Published public private(set) var feedIsEmpty = false
    
    private var caloriesMetric: HealthMetric?
    private let healthService: HealthDataServiceable
    
    public init(
        healthService: HealthDataServiceable
    ) {
        self.healthService = healthService
    }
}

// MARK: - SimpleRecommendationsViewModellable
extension SimpleRecommendationsViewModel: SimpleRecommendationsViewModellable {
    public func load() async {
        isLoading = true
        defer {
            isLoading = false
        }
        
        let result = await healthService.fetchCalories(for: .now, unit: .kilocalorie())
        switch result {
        case .success(let returnedCalorieMetric):
            self.caloriesMetric = returnedCalorieMetric
            if let burnedCalories = returnedCalorieMetric.value.intValue {
                let recomendations = Self.recommendationPresentationModels(fromBurnedCalories: burnedCalories)
                recommendationPresentationModels = recomendations
                feedIsEmpty = recommendationPresentationModels.isEmpty
            } else {
                safePrint("⛔️ Failed to return inte value for burned calories metric")
            }
        case .failure(let error):
            safePrint("⛔️ Failed to load recommendations: error not handled for now")
        }
    }
}

// MARK: - Factory Helpers
extension SimpleRecommendationsViewModel {
    private static func recommendationPresentationModels(
        fromBurnedCalories burnedCalories: Int
    ) -> [SimpleRecommendationPresentationModellabe] {
        let models: [SimpleRecommendationPresentationModel]
        switch burnedCalories {
        case 0..<200:
            models = [
                .init(emoji: "🚶", title: "Take a Walk", description: "A 20-min brisk walk can get your day going."),
                .init(emoji: "🧘", title: "Stretch It Out", description: "Do 5 mins of stretching to ease in.")
            ]
        case 200..<500:
            models = [
                .init(emoji: "🏃", title: "Quick Run", description: "A 10-min jog can power up your numbers."),
                .init(emoji: "💪", title: "Mini Workout", description: "Try 15 mins of bodyweight exercises.")
            ]
        case 500..<650:
            models = [
                .init(emoji: "🔥", title: "One Last Push", description: "You’re nearly there—just a short walk left."),
                .init(emoji: "🎯", title: "Stretch Goal", description: "Go beyond your burn goal for bonus health!")
            ]
        default:
            models = [
                .init(emoji: "✅", title: "Goal Crushed", description: "You hit your burn target—amazing job!"),
                .init(emoji: "🌟", title: "Keep Glowing", description: "Cool down with some gentle yoga.")
            ]
        }
        return models
    }
}
