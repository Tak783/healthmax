//
//  SimpleRecommendation.swift
//  CoreHealthMaxModels
//
//  Created by Tak Mazarura on 11/06/2025.
//

public struct SimpleRecommendation: Identifiable {
    public let id: String
    public let emoji: String
    public let title: String
    public let description: String
    
    public init(
        id: String,
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
