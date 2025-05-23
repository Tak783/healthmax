//
//  ErrorView.swift
//  RecipesClient
//
//  Created by Tak Mazarura on 22/05/2025.
//

import CorePresentation
import SwiftUI

struct ErrorView: View {
    let message: String
    let retryAction: () -> Void

    var body: some View {
        VStack(spacing: DesignSystem.Layout.medium) {
            Text(message)
                .foregroundColor(.red)

            Button("Retry", action: retryAction)
        }
        .padding()
    }
}
