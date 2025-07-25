//
//  AppleHealthPermissionsViewModelling.swift
//  QuizFeature
//
//  Created on 23/05/2025.
//

import CoreSharedModels

@MainActor
public protocol AppleHealthPermissionsViewModelling {
    var requestStatus: PermissionRequestStatus { get }
    
    func requestAuthorization() async
}
