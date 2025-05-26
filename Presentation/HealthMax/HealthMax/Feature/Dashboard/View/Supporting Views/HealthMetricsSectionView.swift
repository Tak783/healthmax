//
//  HealthMetricsSectionView.swift
//  HealthMax
//
//  Created on 26/05/2025.
//

import CoreSharedModels
import CorePresentation
import SwiftUI

struct HealthMetricsSectionView: View {
    let title: String
    let metrics: [HealthMetricPresentationModel]
    
    var body: some View {
        VStack(alignment: .leading, spacing: DesignSystem.Layout.medium) {
            Text(title)
                .font(DesignSystem.DSFont.headline())
                .foregroundColor(.white)
            
            LazyVGrid(
                columns: [GridItem(.flexible()), GridItem(.flexible())],
                spacing: DesignSystem.Layout.large
            ) {
                ForEach(metrics, id: \.self) { metric in
                    HealthMetricCardView(metric: metric)
                }
            }
        }
    }
}
