//
//  RecommendationsCarouselView.swift
//  HMaxLite Watch App
//
//  Created by Tak Mazarura on 11/06/2025.
//

import SwiftUI
import CorePresentation
import UserBiometricsFeature

struct RecommendationsCarouselView: View {
    @StateObject var viewModel: SimpleRecommendationsViewModel

    var body: some View {
        ZStack {
            DesignSystem.DSGradient.background
                .ignoresSafeArea()

            Group {
                VStack {
                    if viewModel.isLoading {
                        loadingView
                    } else if viewModel.recommendationPresentationModels.isEmpty {
                        emptyStateView
                    } else {
                        recommendationsTabView
                    }
                }
            }
            .padding()
        }
        .onAppear {
            Task {
                await viewModel.load()
            }
        }
    }
}

// MARK: - Supporting Views
extension RecommendationsCarouselView {
    var loadingView: some View {
        ProgressView("Loading...")
    }

    var emptyStateView: some View {
        VStack(spacing: DesignSystem.Layout.extraSmall) {
            Text("👋")
                .font(.system(size: 20, weight: .bold))
                .multilineTextAlignment(.center)
            Text("No recommendations yet!")
                .font(.system(size: 13, weight: .bold))
                .multilineTextAlignment(.center)
            Text("Make sure you've set up Apple Health in HealthMax iPhone App")
                .font(.system(size: 12, weight: .light))
                .multilineTextAlignment(.center)
        }
        .padding()
    }

    var recommendationsTabView: some View {
        TabView {
            summarySlide
            if viewModel.didNotBurnEnoughCalories {
                completionSlide
            }
            ForEach(viewModel.recommendationPresentationModels) { recommendation in
                VStack(spacing: DesignSystem.Layout.extraSmall) {
                    Text(recommendation.emoji)
                        .font(.system(size: 20, weight: .bold))
                        .multilineTextAlignment(.center)
                    Text(recommendation.title)
                        .font(.system(size: 16, weight: .bold))
                        .multilineTextAlignment(.center)
                    Text(recommendation.description)
                        .font(.system(size: 15, weight: .light))
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                .padding()
            }
            if viewModel.didNotBurnEnoughCalories {
                encouragmentSlide
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
    }

    var summarySlide: some View {
        VStack(spacing: DesignSystem.Layout.extraSmall) {
            Text(viewModel.didNotBurnEnoughCalories ? "🔥" : "🥳")
                .font(.system(size: 20, weight: .bold))
                .multilineTextAlignment(.center)
            Text("You've burned")
                .font(.system(size: 16, weight: .heavy))
                .multilineTextAlignment(.center)
            Text("\(viewModel.burnedCalories) calories today")
                .font(.system(size: 16, weight: .heavy))
                .multilineTextAlignment(.center)
        }
        .padding()
    }
    
    var completionSlide: some View {
        VStack(spacing: DesignSystem.Layout.extraSmall) {
            Text("⚡️")
                .font(.system(size: 20, weight: .bold))
                .multilineTextAlignment(.center)
            Text("Here are some ways\nyou can burn more calories today")
                .font(.system(size: 14, weight: .bold))
                .multilineTextAlignment(.center)
            Text("➡️")
                .font(.system(size: 16, weight: .light))
                .multilineTextAlignment(.center)
            Spacer()
        }
        .padding()
    }
    
    var encouragmentSlide: some View {
        VStack(spacing: DesignSystem.Layout.extraSmall) {
            Text("⚡️")
                .font(.system(size: 20, weight: .bold))
                .multilineTextAlignment(.center)
            Text("You can do it!")
                .font(.system(size: 16, weight: .heavy))
                .multilineTextAlignment(.center)
            Text("The best time to start is now!")
                .font(.system(size: 14, weight: .medium))
                .multilineTextAlignment(.center)
            Spacer()
        }
        .padding()
    }
}
