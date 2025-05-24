//
//  AppleHealthPermissionsViewModelling.swift
//  QuizFeature
//
//  Created by Tak Mazarura on 23/05/2025.
//

@MainActor
protocol AppleHealthPermissionsViewModelling {
    var requestStatus: HealthPermissionRequestStatus { get }
    
    func requestAuthorization() async
}
