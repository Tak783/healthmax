//
//  HealthMaxApp.swift
//  HealthMax
//
//  Created on 20/05/2025.
//

import SwiftUI
import Firebase
import CoreHealthMaxModels
import CoreHealthKit
import SwiftUI
import UserBiometricsFeature

@main
struct HealthMaxApp: App {
    @Environment(\.scenePhase) private var scenePhase
    
    init() {
        FirebaseApp.configure()
        Task {
            let authManager = AuthManager()
            await authManager.signInAnonymously()
        }
    }
    
    var body: some Scene {
        WindowGroup {
            LaunchViewFactory.launchView()
                .onChange(of: scenePhase) { _, newPhase in
                    scenePhaseDidChange(to: newPhase)
                }
                .onAppear {
                    let healthService = HealthKitHealthDataService()
                    let biometricsService = UserDefaultsFetchUserBiometricsService()
                    let recommendationService = RemoteHealthRecommendationService()
                    
                    let healthDashboardViewModel = RecommendationsViewModel(
                        healthService: healthService,
                        biometricsService: biometricsService,
                        recommendationService: recommendationService
                    )
                    Task {
                        await healthDashboardViewModel.load()
                    }
                }
        }
    }
}

// MARK: - Helpers
extension HealthMaxApp {
    private func scenePhaseDidChange(to newPhase: ScenePhase) {
        switch newPhase {
        case .background, .inactive:
            EngagementNotificationScheduler.scheduleNotificationIfNeeded()
        default:
            break
        }
    }
}


fileprivate final class AuthManager {
    func signInAnonymously() async {
        do {
            let result = try await Auth.auth().signInAnonymously()
            print("✅ Signed in anonymously: \(result.user.uid)")
        } catch {
            print("❌ Failed to sign in: \(error.localizedDescription)")
        }
    }
}
