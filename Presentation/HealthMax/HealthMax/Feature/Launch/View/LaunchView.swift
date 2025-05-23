//
//  WelcomeView.swift
//  HealthMax
//
//  Created by Tak Mazarura on 22/05/2025.
//

import SwiftUI

struct LaunchView: View {
    @StateObject var coordinator: LaunchCoordinator
    
    var body: some View {
        NavigationStack(path: $coordinator.navigationPath) {
            contentView
                .navigationDestination(
                    for: LaunchCoordinator.NavigationDestination.self
                ) { destination in
                    LaunchRouter.navigateToDestination(destination)
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
        Color(uiColor: .systemBackground)
            .ignoresSafeArea()
    }
    
    private var mainView: some View {
        VStack(spacing: 12) {
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
        VStack(spacing: 12) {
            Text("Welcome to!")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            
            Text("healthMax.AI")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(.primary)
            
            Text("Maximising your health\nmade easy")
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(.primary)
                .padding(.top, 8)
        }
    }
    
    private var getStartedButton: some View {
        Button(action: {
            coordinator.navigateToDashboard()
        }) {
            HStack {
                Text("Get Started")
                Image(systemName: "arrow.right")
            }
            .fontWeight(.bold)
            .foregroundColor(Color(uiColor: .systemBackground))
            .frame(maxWidth: .infinity)
            .padding()
            .background(.primary)
            .cornerRadius(30)
        }
        .padding(.horizontal, 32)
    }
}
