//
//  QuizAnswerChoice.swift
//  QuizFeature
//
//  Created on 22/05/2025.
//

import Foundation

public struct QuizAnswerChoice: Identifiable, Codable, Sendable {
    public let id: String
    public let title: String
    public let icon: Icon?
    
    public init(id: String, title: String, icon: QuizAnswerChoice.Icon? = nil) {
        self.id = id
        self.title = title
        self.icon = icon
    }
    
    public struct Icon: Codable, Sendable {
        public let emojiName: String?
        public let title: String?
        public let assetName: String?

        public init(emojiName: String? = nil, title: String? = nil, assetName: String? = nil) {
            self.emojiName = emojiName
            self.title = title
            self.assetName = assetName
        }
    }
}
