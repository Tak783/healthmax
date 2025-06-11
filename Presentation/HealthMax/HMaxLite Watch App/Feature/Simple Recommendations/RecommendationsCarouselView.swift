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
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if viewModel.recommendationPresentationModels.isEmpty {
                    VStack(spacing: 4) {
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
                } else {
                    TabView {
                        ForEach(viewModel.recommendationPresentationModels) { recommendation in
                            VStack(spacing: 4) {
                                Text(recommendation.emoji)
                                    .font(.system(size: 20, weight: .bold))
                                    .multilineTextAlignment(.center)
                                Text(recommendation.title)
                                    .font(.system(size: 13, weight: .bold))
                                    .multilineTextAlignment(.center)
                                Text(recommendation.description)
                                    .font(.system(size: 12, weight: .light))
                                    .multilineTextAlignment(.center)
                            }
                            .padding()
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
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
