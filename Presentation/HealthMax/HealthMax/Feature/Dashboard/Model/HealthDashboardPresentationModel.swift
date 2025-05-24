//
//  HealthDashboardItem.swift
//  HealthMax
//
//  Created by Tak Mazarura on 24/05/2025.
//

import CorePresentation
import Foundation

struct HealthDashboardPresentationModel: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let detail: String
    let image: LocalImage

    init(title: String, detail: String, image: LocalImage) {
        self.title = title
        self.detail = detail
        self.image = image
    }
}
