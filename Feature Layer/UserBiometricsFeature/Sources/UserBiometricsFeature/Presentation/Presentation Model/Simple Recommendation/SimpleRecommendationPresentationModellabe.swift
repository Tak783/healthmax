//
//  SimpleRecommendationPresentationModellabe.swift
//  CoreHealthMaxModels
//
//  Created by Tak Mazarura on 11/06/2025.
//

import Foundation

public protocol SimpleRecommendationPresentationModellabe: Sendable, Identifiable {
    var id: String { get }
    var emoji: String { get }
    var title: String { get }
    var description: String { get }
}
