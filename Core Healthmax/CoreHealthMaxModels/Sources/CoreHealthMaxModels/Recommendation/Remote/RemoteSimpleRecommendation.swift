//
//  RemoteSimpleRecommendation.swift
//  CoreHealthMaxModels
//
//  Created by Tak Mazarura on 11/06/2025.
//

struct RemoteSimpleRecommendation: Identifiable, Decodable {
    let id: String
    let emoji: String
    let title: String
    let description: String
}

// MARK: - Helpers
extension RemoteSimpleRecommendation {
    func toModel() -> SimpleRecommendation {
        .init(
            id: id,
            emoji: emoji,
            title: title,
            description: description
        )
    }
}
