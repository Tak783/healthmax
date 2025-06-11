//
//  QuizPermissonRequestStepView.swift
//  QuizFeature
//
//  Created on 23/05/2025.
//

import CorePresentation
import CoreSharedModels
import CoreFoundational
import QuizFeature
import SwiftUI
import CoreUIKit

struct AppleHealthPermissonRequestStepView: View {
    @ObservedObject var quizViewModel: QuizViewModel
    @ObservedObject var quizPermissonStepViewModel: QuizPermissonStepViewModel
    @ObservedObject var appleHealthPermissionsViewModel: AppleHealthPermissionsViewModel
    
    var body: some View {
        contentView
            .onChange(of: appleHealthPermissionsViewModel.requestStatus) { _, newStatus in
                didUpdatePermissionRequestStatus(newStatus)
            }
    }
}

// MARK: - Main Views
extension AppleHealthPermissonRequestStepView {
    private var contentView: some View {
        VStack(spacing: 24) {
            Spacer()
            infoView
            Spacer()
            continueButton
        }
        .padding()
    }
}
 
// MARK: - Supporting Views
extension AppleHealthPermissonRequestStepView {
    private var infoView: some View {
        VStack(alignment: .center, spacing: 16) {
            imageView
            Text(quizPermissonStepViewModel.permissionContent.title)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .font(DesignSystem.DSFont.largeTitle())
            Text(quizPermissonStepViewModel.permissionContent.detail)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.white)
                .font(DesignSystem.DSFont.headline(weight: .regular))
        }
    }
    
    @ViewBuilder
    private var imageView: some View {
        let image = quizPermissonStepViewModel.permissionContent.image
        switch image.type {
        case .system:
            Image(systemName: image.name)
        case .emoji:
            Text(image.name)
        case .asset:
            Image(image.name)
        }
    }
    
    private var continueButton: some View {
        HStack(alignment: .center) {
            if appleHealthPermissionsViewModel.requestStatus == .requesting {
                VStack(spacing: DesignSystem.Layout.medium) {
                    Text("Connecting to Apple Health")
                        .foregroundColor(.white)
                        .font(DesignSystem.DSFont.footnote(weight: .bold))
                        .multilineTextAlignment(.center)
                    ProgressView()
                        .tint(.white)
                }
            } else {
                HapticImpactButton {
                    Task {
                        await appleHealthPermissionsViewModel.requestAuthorization()
                    }
                } label: {
                    HStack {
                        Spacer()
                        Text("Continue")
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
}

// MARK: - Helpers
extension AppleHealthPermissonRequestStepView {
    func didUpdatePermissionRequestStatus(_ status: PermissionRequestStatus) {
        switch status {
        case .authorised, .denied:
            quizViewModel.processStepAction(.finishStep)
        case .requesting, .unknown:
            break
        }
    }
}
