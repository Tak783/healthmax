//
//  HealthDashboardView.swift
//  HealthMax
//
//  Created on 24/05/2025.
//

import CoreFoundational
import CorePresentation
import CoreSharedModels
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
                .navigationBarTitleDisplayMode(.inline)
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
        if viewModel.isLoading {
            LoadingView()
        } else if viewModel.feedIsEmpty {
            MetricsErrorView {
                loadFeed()
            }
        } else {
            VStack(spacing: DesignSystem.Layout.medium) {
                metricsScrollView
                unlockPremiumView
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
    
    private var metricsScrollView: some View {
        ScrollView {
            VStack(spacing: DesignSystem.Layout.extraExtraLarge) {
                if !viewModel.staticMetricPresentationModels.isEmpty {
                    HealthMetricsSectionView(
                        title: "Entered Metrics",
                        metrics: viewModel.staticMetricPresentationModels
                    )
                }
                
                if !viewModel.dynamicMetricsPresentationModels.isEmpty {
                    HealthMetricsSectionView(
                        title: "Apple Health Metrics",
                        metrics: viewModel.dynamicMetricsPresentationModels
                    )
                }
            }
        }
    }
    
    private var unlockPremiumView: some View {
        VStack(spacing: DesignSystem.Layout.medium) {
            premiumUnlockBanner
            paywallButton
        }
    }
    
    private var premiumUnlockBanner: some View {
        Text("Unlock HEALTHMAX.AI Premium to\nmaximise your health")
            .font(.footnote)
            .foregroundColor(.white.opacity(0.8))
            .multilineTextAlignment(.center)
            .padding(.top, 32)
            .frame(maxWidth: .infinity)
    }
    
    private var paywallButton: some View {
        HStack(alignment: .center) {
            HapticImpactButton {
                safePrint("Did request to open paywall")
            } label: {
                HStack {
                    Spacer()
                    Text("Start Maximising Your Health")
                        .foregroundColor(.white)
                        .font(DesignSystem.DSFont.subHeadline(weight: .bold))
                        .multilineTextAlignment(.center)
                    Image(systemName: "arrow.right.circle.fill")
                        .tint(.white)
                    Spacer()
                }
                .padding()
                .background(DesignSystem.DSGradient.button)
                .cornerRadius(DesignSystem.Layout.huge)
                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
            }
        }
    }
}
