//
//  HealthDashboardView.swift
//  HealthMax
//
//  Created by Tak Mazarura on 24/05/2025.
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
                .navigationTitle("Home")
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
            } else {
                ScrollView {
                    VStack(spacing: 24) {
                        if !viewModel.staticMetrics.isEmpty {
                            metricsSection(title: "Entered Metrics", metrics: viewModel.staticMetrics)
                        }
                        
                        if !viewModel.dynamicMetrics.isEmpty {
                            metricsSection(title: "Apple Health Metrics", metrics: viewModel.dynamicMetrics)
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
    @ViewBuilder
    private func metricsSection(title: String, metrics: [HealthMetric]) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.custom("Impact", size: 22))
                .foregroundColor(.white)
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                ForEach(metrics, id: \.self) { metric in
                    metricCard(metric)
                }
            }
        }
    }
    
    private func metricCard(_ metric: HealthMetric) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            imageView(withImage:  metric.image)
            
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
        .clipShape(RoundedRectangle(cornerRadius: 12))
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
