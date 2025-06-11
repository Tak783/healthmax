//
//  SimpleRecommendationsViewModel.swift
//  UserBiometricsFeature
//
//  Created by Tak Mazarura on 11/06/2025.
//

import Foundation
import HealthKit
import CoreFoundational
import CoreHealthKit
import CoreHealthMaxModels

@MainActor
protocol SimpleRecommendationsViewModellable {
    var recommendationPresentationModels: [SimpleRecommendationPresentationModel] { get }
    func load() async
}
 
@MainActor
public final class SimpleRecommendationsViewModel: ObservableObject {
    @Published public var isLoading = false
    @Published public var recommendationPresentationModels = [SimpleRecommendationPresentationModel]()
    @Published public private(set) var feedIsEmpty = false
    
    private var caloriesMetric: HealthMetric?
    private let healthService: HealthDataServiceable
    private let healthStore = HKHealthStore()
    
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

        let authorized = await requestAuthorizationIfNeeded()
        guard authorized else {
            safePrint("⛔️ HealthKit authorization failed")
            return
        }

        let result = await healthService.fetchCalories(for: .now, unit: .kilocalorie())
        switch result {
        case .success(let returnedCalorieMetric):
            self.caloriesMetric = returnedCalorieMetric
            if let burnedCalories = returnedCalorieMetric.value.intValue {
                let recommendations = Self.recommendationPresentationModels(fromBurnedCalories: burnedCalories)
                recommendationPresentationModels = recommendations
                feedIsEmpty = recommendations.isEmpty
            } else {
                safePrint("⛔️ Failed to return int value for burned calories metric")
            }
        case .failure(let error):
            safePrint("⛔️ Failed to load recommendations: \(error.localizedDescription)")
        }
        isLoading = false
    }

    private func requestAuthorizationIfNeeded() async -> Bool {
        let typesToRead: Set = [
            HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!
        ]

        do {
            try await healthStore.requestAuthorization(toShare: [], read: typesToRead)
            return true
        } catch {
            safePrint("⚠️ HealthKit requestAuthorization error: \(error.localizedDescription)")
            return false
        }
    }
}

// MARK: - Factory Helpers
extension SimpleRecommendationsViewModel {
    private static func recommendationPresentationModels(
        fromBurnedCalories burnedCalories: Int
    ) -> [SimpleRecommendationPresentationModel] {
        switch burnedCalories {
        case 0..<200:
            return [
                .init(emoji: "🚶", title: "Take a Walk", description: "A 20-min brisk walk can get your day going."),
                .init(emoji: "🧘", title: "Stretch It Out", description: "Do 5 mins of stretching to ease in.")
            ]
        case 200..<500:
            return [
                .init(emoji: "🏃", title: "Quick Run", description: "A 10-min jog can power up your numbers."),
                .init(emoji: "💪", title: "Mini Workout", description: "Try 15 mins of bodyweight exercises.")
            ]
        case 500..<650:
            return [
                .init(emoji: "🔥", title: "One Last Push", description: "You’re nearly there—just a short walk left."),
                .init(emoji: "🎯", title: "Stretch Goal", description: "Go beyond your burn goal for bonus health!")
            ]
        default:
            return [
                .init(emoji: "✅", title: "Goal Crushed", description: "You hit your burn target—amazing job!"),
                .init(emoji: "🌟", title: "Keep Glowing", description: "Cool down with some gentle yoga.")
            ]
        }
    }
}
