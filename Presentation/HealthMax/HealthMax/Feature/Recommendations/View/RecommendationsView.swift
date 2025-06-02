//
//  RecommendationsView.swift
//  HealthMax
//
//  Created by Tak Mazarura on 02/06/2025.
//

import CorePresentation
import CoreSharedModels
import SwiftUI
import CoreHealthMaxModels

struct RecommendationsListView: View {
    @ObservedObject var viewModel: RecommendationsViewModel
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            DesignSystem.DSGradient.background.ignoresSafeArea()
            content
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        closeButton
                    }
                    ToolbarItem(placement: .principal) {
                        navBarTitleView
                    }
                }
                .navigationBarBackButtonHidden(true)
                .navigationBarTitleDisplayMode(.inline)
                .onAppear {
                    loadFeed()
                }
        }
    }
}

// MARK: - Supporting VIews
extension RecommendationsListView {
    private var navBarTitleView: some View {
        Text("HealthMax Plan")
            .font(.custom("Impact", size: 24))
            .foregroundColor(.white)
    }
    
    private var closeButton: some View {
        Button {
            Task {
                dismiss()
            }
        } label: {
            Image(systemName: "xmark")
                .imageScale(.medium)
                .foregroundColor(.white)
        }
    }
    
    private var content: some View {
        ScrollView {
            VStack(spacing: DesignSystem.Layout.large) {
                ForEach(viewModel.recommendationPresentationModels, id: \.self) { recommendation in
                    recommendationCard(for: recommendation)
                }
            }
            .padding()
        }
    }

    private func recommendationCard(for recommendation: HealthImprovementRecommendation) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            header(for: recommendation)
            metrics(for: recommendation)
            summary(for: recommendation)
            actions(for: recommendation)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: DesignSystem.Layout.medium))
    }

    private func header(for recommendation: HealthImprovementRecommendation) -> some View {
        HStack {
            imageView(withImage: recommendation.metricType.icon)
            Text(recommendation.metricType.displayName.capitalized)
                .font(.headline)
            Spacer()
            Text("Goal: \(recommendation.targetTrend.rawValue.capitalized)")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }

    private func metrics(for recommendation: HealthImprovementRecommendation) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("Current Value: \(Int(recommendation.currentValue))")
                    .font(.body)
            if let target = recommendation.targetValue {
                Text("Target: \(Int(target))")
                    .font(.subheadline)
            } else if let range = recommendation.targetRange {
                Text("Target Range: \(Int(range.lowerBound)) – \(Int(range.upperBound))")
                    .font(.subheadline)
            }
        }
    }

    private func summary(for recommendation: HealthImprovementRecommendation) -> some View {
        Text(recommendation.summary)
            .font(.body)
            .padding(.top, 4)
    }

    private func actions(for recommendation: HealthImprovementRecommendation) -> some View {
        Group {
            if !recommendation.actions.isEmpty {
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(recommendation.actions.indices, id: \.self) { i in
                        Text("• \(recommendation.actions[i])")
                            .font(.callout)
                    }
                }
                .padding(.top, 6)
            }
        }
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

// MARK: - Helpers
extension RecommendationsListView {
    func loadFeed() {
        Task {
            await viewModel.load()
        }
    }
}
