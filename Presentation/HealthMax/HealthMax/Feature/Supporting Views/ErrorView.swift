//
//  ErrorView.swift
//  RecipesClient
//
//  Created by Tak Mazarura on 22/05/2025.
//

import SwiftUI

struct ErrorView: View {
    let message: String
    let retryAction: () -> Void

    var body: some View {
        VStack(spacing: 12) {
            Text(message)
                .foregroundColor(.red)

            Button("Retry", action: retryAction)
        }
        .padding()
    }
}
