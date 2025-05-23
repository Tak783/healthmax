//
//  LocalImage.swift
//  CorePresentation
//
//  Created by Tak Mazarura on 23/05/2025.
//

public struct LocalImage: Codable, Equatable, Sendable {
    public enum ImageType: String, Codable, Sendable {
        case emoji
        case system
        case asset
    }

    public let name: String
    public let type: ImageType

    @MainActor public static let `default` = LocalImage(name: "exclamationmark.circle", type: .system)
    
    public init(name: String, type: LocalImage.ImageType) {
        self.name = name
        self.type = type
    }
}
