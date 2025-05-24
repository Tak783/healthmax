//
//  LoadingView.swift
//  RecipesClient
//
//  Created on 22/05/2025.
//

import SwiftUI

struct LoadingView: View {
    var message: String = "Loading..."

    var body: some View {
        ProgressView(message)
            .padding()
    }
}
