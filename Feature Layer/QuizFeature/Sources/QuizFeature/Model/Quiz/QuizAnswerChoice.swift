//
//  QuizAnswerChoice.swift
//  QuizFeature
//
//  Created by Tak Mazarura on 22/05/2025.
//

import Foundation

public struct QuizAnswerChoice: Identifiable, Codable, Sendable {
    public let id: String
    public let title: String
    public let score: Int
    public let icon: Icon?
    
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
