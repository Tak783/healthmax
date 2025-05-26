//
//  HealthMetricCardView.swift
//  HealthMax
//
//  Created on 26/05/2025.
//

import CorePresentation
import CoreSharedModels
import SwiftUI

struct HealthMetricCardView: View {
    let metric: HealthMetricPresentationModel
    
    init(metric: HealthMetricPresentationModel) {
        self.metric = metric
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: DesignSystem.Layout.extraSmall) {
            imageView(withImage: metric.icon)
            titleView
            metricView
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: DesignSystem.Layout.medium))
    }
}

// MARK: - Supporting Views
private extension HealthMetricCardView {
    var titleView: some View {
        Text(metric.title)
            .font(.caption)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .lineLimit(1)
        
    }
    
    var metricView: some View {
        Text(metric.value)
            .font(.footnote)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .lineLimit(1)
    }
    
    @ViewBuilder
    private func imageView(withImage localImage: LocalImage) -> some View {
        switch localImage.type {
        case .system:
            Image(systemName: localImage.name)
        case .emoji:
            Text(localImage.name).foregroundColor(.white)
        case .asset:
            Image(localImage.name)
        }
    }
}
