//
//  DesignSystem+Layout.swift
//  CorePresentation
//
//  Created by Tak Mazarura on 23/05/2025.
//

import SwiftUI

extension DesignSystem {
    public enum Border {
        /// Extra thin border (1pt)
        public static let extraThin: CGFloat = 1

        /// Thin border (2pt)
        public static let thin: CGFloat = 2

        /// Medium border (4pt)
        public static let medium: CGFloat = 4

        /// Large border (6pt)
        public static let large: CGFloat = 6

        /// Extra large border (8pt)
        public static let extraLarges: CGFloat = 8
    }
    
    public enum Layout {
        /// Extra small spacing (4pt)
        public static let extraSmall: CGFloat = 4
        
        /// Small spacing (8pt)
        public static let small: CGFloat = 8
        
        /// Medium spacing (12pt)
        public static let medium: CGFloat = 12
        
        /// Large spacing (16pt)
        public static let large: CGFloat = 16
        
        /// Large spacing (20)
        public static let extraLarge: CGFloat = 20
        
        /// Extra large spacing (24pt)
        public static let extraExtraLarge: CGFloat = 24
        
        /// Extra extra large spacing (32pt)
        public static let huge: CGFloat = 32
    }
}
