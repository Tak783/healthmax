//
//  Coordinating.swift
//  HealthMax
//
//  Created by Tak Mazarura on 22/05/2025.
//

import SwiftUI

@MainActor
protocol Coordinating: AnyObject {
    associatedtype Destination: Hashable
   
    var navigationPath: NavigationPath { get set }

    func navigate(toDestination destination: Destination)
    func pop()
    func popToRoot()
}

// MARK: - Default Implementation
extension Coordinating {
    func navigate(toDestination destination: Destination) {
        navigationPath.append(destination)
    }
    
    func pop() {
        navigationPath.removeLast()
    }

    func popToRoot() {
        navigationPath.removeLast(navigationPath.count)
    }
}
