//
//  RecommendationsCarouselView.swift
//  HMaxLite Watch App
//
//  Created by Tak Mazarura on 11/06/2025.
//

import SwiftUI
import UserBiometricsFeature

struct RecommendationsCarouselView: View {
    @StateObject var viewModel: SimpleRecommendationsViewModel

    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView("Loading...")
            } else if viewModel.recommendationPresentationModels.isEmpty {
                Text("No recommendations yet!")
                    .multilineTextAlignment(.center)
            } else {
                TabView {
                    ForEach(viewModel.recommendationPresentationModels) { recomendation in
                        VStack(spacing: 6) {
                            Text(recomendation.emoji)
                                .font(.largeTitle)
                            Text(recomendation.title)
                                .font(.headline)
                            Text(recomendation.description)
                                .font(.caption)
                                .multilineTextAlignment(.center)
                        }
                        .padding()
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            }
        }
        .onAppear {
            Task {
                await viewModel.load()
            }
        }
    }
}
