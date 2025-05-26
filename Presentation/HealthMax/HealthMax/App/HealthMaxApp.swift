//
//  HealthMaxApp.swift
//  HealthMax
//
//  Created on 20/05/2025.
//

import SwiftUI

@main
struct HealthMaxApp: App {
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            LaunchViewFactory.launchView()
                .onChange(of: scenePhase) { _, newPhase in
                    scenePhaseDidChange(to: newPhase)
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
