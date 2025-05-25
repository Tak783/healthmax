//
//  HealthDashboardView.swift
//  HealthMax
//
//  Created on 24/05/2025.
//

import CorePresentation
import SwiftUI

struct HealthDashboardView: View {
    @StateObject var viewModel: HealthDashboardViewModel
    
    var body: some View {
        ZStack {
            DesignSystem.DSGradient.background.ignoresSafeArea()
            content
                .padding()
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        navBarTitleView
                    }
                }
                .navigationBarBackButtonHidden(true)
                .onAppear {
                    loadFeed()
                }
        }
    }
}

// MARK: - Helpers
extension HealthDashboardView {
    func loadFeed() {
        Task {
            await viewModel.load()
        }
    }
}

// MARK: - Main View
extension HealthDashboardView {
    @ViewBuilder
    private var content: some View {
        ZStack {
            if viewModel.isLoading {
                LoadingView()
            } else if viewModel.feedIsEmpty {
                MetricsErrorView {
                    loadFeed()
                }
            } else {
                ScrollView {
                    VStack(spacing: 24) {
                        if !viewModel.staticMetricPresentationModels.isEmpty {
                            metricsSection(title: "Entered Metrics", metrics: viewModel.staticMetricPresentationModels)
                        }
                        
                        if !viewModel.dynamicMetricsPresentationModels.isEmpty {
                            metricsSection(title: "Apple Health Metrics", metrics: viewModel.dynamicMetricsPresentationModels)
                        }
                        
                        premiumUnlockBanner
                    }
                }
            }
        }
    }
}

// MARK: - Supporting Views
extension HealthDashboardView {
    private var navBarTitleView: some View {
        Text("Home")
            .font(.custom("Impact", size: 24))
            .foregroundColor(.white)
    }
    
    @ViewBuilder
    private func metricsSection(title: String, metrics: [HealthMetricPresentationModel]) -> some View {
        VStack(alignment: .leading, spacing: DesignSystem.Layout.medium) {
            Text(title)
                .font(DesignSystem.DSFont.headline())
                .foregroundColor(.white)
            
            LazyVGrid(
                columns: [GridItem(.flexible()), GridItem(.flexible())],
                spacing: DesignSystem.Layout.large
            ) {
                ForEach(metrics, id: \.self) { metric in
                    metricCard(metric)
                }
            }
        }
    }
    
    private func metricCard(_ metric: HealthMetricPresentationModel) -> some View {
        VStack(alignment: .leading, spacing: DesignSystem.Layout.extraSmall) {
            imageView(withImage:  metric.icon)
            
            Text(metric.title)
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            
            Text(metric.value)
                .font(.headline)
                .foregroundColor(.white)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: DesignSystem.Layout.medium))
    }
    
    private var premiumUnlockBanner: some View {
        Text("Unlock HealthMax.AI Premium to\nmaximise your health")
            .font(.footnote)
            .foregroundColor(.white.opacity(0.8))
            .multilineTextAlignment(.center)
            .padding(.top, 32)
            .frame(maxWidth: .infinity)
    }
    
    @ViewBuilder
    private func imageView(withImage localImage: LocalImage) -> some View {
        switch localImage.type {
        case .system:
            Image(systemName: localImage.name)
        case .emoji:
            Text(localImage.name)
                .foregroundColor(.white)
        case .asset:
            Image(localImage.name)
        }
    }
}
