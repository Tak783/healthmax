//
//  WelcomeView.swift
//  HealthMax
//
//  Created on 22/05/2025.
//

import CorePresentation
import SwiftUI
import CoreUIKit

struct LaunchView: View {
    @StateObject var coordinator: LaunchCoordinator
    
    var body: some View {
        NavigationStack(path: $coordinator.navigationPath) {
            contentView
                .navigationDestination(
                    for: LaunchCoordinator.NavigationDestination.self
                ) { destination in
                    LaunchRouter.navigateToDestination(destination, coordinator: coordinator)
                }
        }
    }
}

// MARK: - Core Views
extension LaunchView {
    private var contentView: some View {
        ZStack {
            backgroundView
            mainView
        }
    }
    
    private var backgroundView: some View {
        DesignSystem.DSGradient.background
            .ignoresSafeArea()
    }
    
    private var mainView: some View {
        VStack(spacing: DesignSystem.Layout.medium) {
            Spacer()
            welcomeTextSection
            Spacer()
            getStartedButton
        }
        .padding()
    }
}

// MARK: - Supporting Views
extension LaunchView {
    private var welcomeTextSection: some View {
        VStack(spacing: DesignSystem.Layout.medium) {
            Text("Welcome to!")
                .font(DesignSystem.DSFont.title(weight: .bold))
                .foregroundColor(.white)
            
            Text("HEALTHMAX.AI")
                .font(.custom("Impact", size: 45))
                .foregroundColor(.white)
            
            Text("Maximising your health\nmade easy")
                .font(DesignSystem.DSFont.title(weight: .bold))
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .padding(.top, DesignSystem.Layout.medium)
        }
    }
    
    private var getStartedButton: some View {
        HStack(alignment: .center) {
            HapticImpactButton {
                coordinator.navigateToOnboardingQuiz()
            } label: {
                HStack {
                    Spacer()
                    Text("Get Started")
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
