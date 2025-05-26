//
//  NotificationPermissionRequesting.swift
//  QuizFeature
//
//  Created on 24/05/2025.
//

import CoreSharedModels
import SwiftUI

@MainActor
public protocol NotificationPermissionRequesting: ObservableObject {
    var requestStatus: PermissionRequestStatus { get }

    func requestAuthorization() async
}
