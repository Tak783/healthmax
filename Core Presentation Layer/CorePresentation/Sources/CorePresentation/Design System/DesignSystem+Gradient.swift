//
//  Gradient.swift
//  CorePresentation
//
//  Created by Tak Mazarura on 23/05/2025.
//

import SwiftUI

public extension DesignSystem {
    struct DSGradient {
        public static let background = LinearGradient(
            gradient: Gradient(colors: [
                Color(red: 43/255, green: 0/255, blue: 92/255),  // deep violet
                Color(red: 9/255, green: 4/255, blue: 53/255)    // dark navy
            ]),
            startPoint: .top,
            endPoint: .bottom
        )
        
        public static let button =  LinearGradient(
            gradient: Gradient(colors: [
                Color(red: 218/255, green: 90/255, blue: 255/255), // light pink-purple
                Color(red: 68/255, green: 133/255, blue: 255/255)  // light blue
            ]),
            startPoint: .leading,
            endPoint: .trailing
        )
    }
}
