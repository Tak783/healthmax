//
//  EngagementNotificationScheduler.swift
//  HealthMax
//
//  Created by Tak Mazarura on 26/05/2025.
//

import CoreFoundational
import Foundation
import NotificationCenter

struct EngagementNotificationScheduler {
    static func scheduleNotificationIfNeeded() {
        let hasScheduledKey = "hasScheduledPlanNotification"
        
        guard !UserDefaults.standard.bool(forKey: hasScheduledKey) else {
            safePrint("🔁 Engagemnt notification already scheduled / Sent")
            return
        }
    
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            guard granted else { return }
            
            let content = UNMutableNotificationContent()
            content.title = "HealthMax.AI"
            content.body = "Your personalised plan to maximise your health is now ready"
            content.sound = .default
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 20, repeats: false)
            
            let request = UNNotificationRequest(
                identifier: "personalisedPlanReady",
                content: content,
                trigger: trigger
            )
            
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    safePrint("❌ Failed to schedule notification: \(error.localizedDescription)")
                } else {
                    safePrint("✅ Scheduled personalised plan notification.")
                    UserDefaults.standard.set(true, forKey: hasScheduledKey)
                }
            }
        }
    }
}
