//
//  HealthMetricsSectionView.swift
//  HealthMax
//
//  Created on 26/05/2025.
//

import UserBiometricsFeature
import CoreSharedModels
import CorePresentation
import SwiftUI

struct HealthMetricsSectionView: View {
    let title: String
    let metrics: [HealthMetricPresentationModel]
    
    var body: some View {
        VStack(alignment: .leading, spacing: DesignSystem.Layout.medium) {
            titleView
            gridView
        }
    }
}

// MARK: - Supporting Views
extension HealthMetricsSectionView {
    private var titleView: some View {
        Text(title)
            .font(DesignSystem.DSFont.headline())
            .foregroundColor(.white)
    }
    
    private var gridView: some View {
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
