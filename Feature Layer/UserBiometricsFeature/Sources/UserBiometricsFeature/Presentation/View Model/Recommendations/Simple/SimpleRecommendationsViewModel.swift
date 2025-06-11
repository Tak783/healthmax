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
public final class SimpleRecommendationsViewModel: ObservableObject {
    @Published public var isLoading = false
    @Published public private(set) var recommendationPresentationModels = [SimpleRecommendationPresentationModel]()
    @Published public private(set) var feedIsEmpty = false
    @Published public private(set) var burnedCalories: Int = 0
    
    private var caloriesMetric: HealthMetric?
    private let healthService: HealthDataServiceable
    private let healthStore = HKHealthStore()
    
    public init(
        healthService: HealthDataServiceable
    ) {
        self.healthService = healthService
    }
}
// MARK: - ViewModelLoadable
extension SimpleRecommendationsViewModel: ViewModelLoadable {}

// MARK: - SimpleRecommendationsViewModellable
extension SimpleRecommendationsViewModel: SimpleRecommendationsViewModellable {
    public func load() async {
        setIsLoading(true)
        
        guard await requestAuthorizationIfNeeded() else {
            safePrint("⛔️ HealthKit authorization failed")
            return
        }
        await perfomLoadMetricsRequest()
        
        setIsLoading(false)
    }
}

// MARK: - Load Feed
extension SimpleRecommendationsViewModel {
    private func perfomLoadMetricsRequest() async {
        let result = await healthService.fetchCalories(for: .now, unit: .kilocalorie())
        switch result {
        case .success(let returnedCalorieMetric):
            didSuccessfullyLoadCalorieMetric(returnedCalorieMetric)
        case .failure(let error):
            safePrint("⛔️ Failed to load recommendations: \(error.localizedDescription)")
        }
    }
    
    private func didSuccessfullyLoadCalorieMetric(_ caloriesMetric: HealthMetric) {
        self.caloriesMetric = caloriesMetric
       
        guard let burnedCalories = caloriesMetric.value.intValue else {
            safePrint("⛔️ Failed to return int value for burned calories metric")
            return
        }
        let presentationModels = Self.recommendationPresentationModels(
            fromBurnedCalories: burnedCalories
        )
        recommendationPresentationModels = presentationModels
        feedIsEmpty = presentationModels.isEmpty
    }
}

// MARK: - Request Authorisation
extension SimpleRecommendationsViewModel {
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
                .init(emoji: "🧘", title: "Stretch It Out", description: "Do 5 mins of stretching to ease in."),
                .init(emoji: "🪑", title: "Stand Break", description: "Stand and stretch for 2 mins to reset."),
                .init(emoji: "🚰", title: "Hydration Time", description: "Grab a glass of water to wake your body."),
                .init(emoji: "🎵", title: "Move to Music", description: "Put on a song and dance for one track.")
            ]
            
        case 200..<500:
            return [
                .init(emoji: "🏃", title: "Quick Run", description: "A 10-min jog can power up your numbers."),
                .init(emoji: "💪", title: "Mini Workout", description: "Try 15 mins of bodyweight exercises."),
                .init(emoji: "🚲", title: "Spin It Up", description: "Hop on a bike for a short indoor session."),
                .init(emoji: "🧗", title: "Climb Something", description: "Use stairs for a quick cardio blast."),
                .init(emoji: "🕺", title: "Active Break", description: "Do jumping jacks or dance around the room.")
            ]
            
        case 500..<650:
            return [
                .init(emoji: "🔥", title: "One Last Push", description: "You’re nearly there—just a short walk left."),
                .init(emoji: "🎯", title: "Stretch Goal", description: "Go beyond your burn goal for bonus health!"),
                .init(emoji: "🤸", title: "Mobility Flow", description: "Try some dynamic stretches to finish strong."),
                .init(emoji: "🚶‍♂️", title: "Lap Finish", description: "One final lap around the block seals the deal."),
                .init(emoji: "🧍", title: "Body Reset", description: "Roll your shoulders and shake it off for recovery.")
            ]
            
        default:
            return [
                .init(emoji: "✅", title: "Goal Crushed", description: "You hit your burn target—amazing job!"),
                .init(emoji: "🌟", title: "Keep Glowing", description: "Cool down with some gentle yoga."),
                .init(emoji: "🛁", title: "Recovery Time", description: "Enjoy a relaxing shower or bath."),
                .init(emoji: "📈", title: "Track Progress", description: "Log your win and reflect on today."),
                .init(emoji: "🍽", title: "Fuel Smart", description: "Refuel with something healthy and satisfying.")
            ]
        }
    }
}
