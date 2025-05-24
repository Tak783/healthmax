//
//  NotificationPermissionRequesting.swift
//  QuizFeature
//
//  Created by Tak Mazarura on 24/05/2025.
//

import SwiftUI

@MainActor
protocol NotificationPermissionRequesting: ObservableObject {
    var requestStatus: NotificationPermissionRequestStatus { get }

    func requestAuthorization() async
}
