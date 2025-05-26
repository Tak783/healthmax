//
//  NotificationPermissionViewModel.swift
//  QuizFeature
//
//  Created on 24/05/2025.
//

import CoreFoundational
import CoreSharedModels
import Foundation
@preconcurrency import UserNotifications

@MainActor
public final class NotificationPermissionViewModel: ObservableObject {
    @Published public private(set) var requestStatus: PermissionRequestStatus = .unknown
    
    private let notificationCenter = UNUserNotificationCenter.current()
    
    public init() {}
}

// MARK: - NotificationPermissionRequesting
extension NotificationPermissionViewModel: NotificationPermissionRequesting {
    public func requestAuthorization() async {
        requestStatus = .requesting
        
        let settings = await notificationCenter.notificationSettings()
        do {
            switch settings.authorizationStatus {
            case .authorized, .provisional:
                requestStatus = .authorised
            case .notDetermined:
                let options: UNAuthorizationOptions = [.alert, .badge, .sound]
                let granted = try await notificationCenter.requestAuthorization(options: options)
                requestStatus = granted ? .authorised : .denied
                if !granted {
                    safePrint("Failed to authorize notifications: user denied access")
                }
            case .denied:
                requestStatus = .denied
                safePrint("Failed to authorize notifications: denied in Settings")
            default:
                requestStatus = .unknown
            }
        } catch {
            requestStatus = .unknown
            safePrint("Failed to authorize notifications: \(error.localizedDescription)")
        }
    }
}
