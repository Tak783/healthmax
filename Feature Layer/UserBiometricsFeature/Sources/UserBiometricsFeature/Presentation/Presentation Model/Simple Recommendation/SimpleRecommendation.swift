//
//  SimpleRecommendation.swift
//  CoreHealthMaxModels
//
//  Created by Tak Mazarura on 11/06/2025.
//

import Foundation

public struct SimpleRecommendationPresentationModel: Identifiable {
    public private(set) var id: String
    public private(set) var emoji: String
    public private(set) var title: String
    public private(set) var description: String
    
    public init(
        id: String = UUID().uuidString,
        emoji: String,
        title: String,
        description: String
    ) {
        self.id = id
        self.emoji = emoji
        self.title = title
        self.description = description
    }
}

// MARK: - SimpleRecommendationPresentationModellabe
extension SimpleRecommendationPresentationModel: SimpleRecommendationPresentationModellabe {}
