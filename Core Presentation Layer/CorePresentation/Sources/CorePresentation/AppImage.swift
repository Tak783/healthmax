//
//  DSImage.swift
//  QuizFeature
//
//  Created by Tak Mazarura on 22/05/2025.
//

public struct AppImage: Codable, Sendable {
    public enum ImageType: Int, Codable, Sendable {
        case system, emoji, asset
    }
    public let type: ImageType
    public let name: String
}
