//
//  DesignSystem.swift
//  CorePresentation
//
//  Created on 23/05/2025.
//

import SwiftUI

public struct DesignSystem {
    public enum DSFont {
        /// Extra Extra large title font (40pt)
        public static func extraExtraLargeTitle(weight: Font.Weight? = nil) -> Font {
            make(size: 56, weight: weight ?? .bold)
        }
        
        /// Extra large title font (40pt), typically used for splash or hero headers.
        public static func extraLargeTitle(weight: Font.Weight? = nil) -> Font {
            make(size: 40, weight: weight ?? .bold)
        }
        
        /// Large title font (36pt), used for main screen titles or prominent headings.
        public static func largeTitle(weight: Font.Weight? = nil) -> Font {
            make(size: 36, weight: weight ?? .bold)
        }
        
        /// Title font (28pt), suitable for section headers or modal titles.
        public static func title(weight: Font.Weight? = nil) -> Font {
            make(size: 28, weight: weight ?? .semibold)
        }
        
        /// Headline font (24pt), ideal for standout text or smaller titles.
        public static func headline(weight: Font.Weight? = nil) -> Font {
            make(size: 24, weight: weight ?? .semibold)
        }
        
        /// Subheadline font (20pt), used for supporting titles or secondary text.
        public static func subHeadline(weight: Font.Weight? = nil) -> Font {
            make(size: 20, weight: weight ?? .semibold)
        }
        
        /// Body font (16pt), used for most paragraph and standard text content.
        public static func body(weight: Font.Weight? = nil) -> Font {
            make(size: 18, weight: weight ?? .regular)
        }
        
        /// Callout font (16pt), useful for small emphasized sections or labels.
        public static func callout(weight: Font.Weight? = nil) -> Font {
            make(size: 16, weight: weight ?? .medium)
        }
        
        /// Callout font (16pt), useful for small emphasized sections or labels.
        public static func subCallout(weight: Font.Weight? = nil) -> Font {
            make(size: 14, weight: weight ?? .bold)
        }
        
        /// Footnote font (12pt), appropriate for secondary or footnote text.
        public static func footnote(weight: Font.Weight? = nil) -> Font {
            make(size: 12, weight: weight ?? .regular)
        }
        
        /// Caption font (12pt), typically used for labels, hints, or disclaimers.
        public static func caption(weight: Font.Weight? = nil) -> Font {
            make(size: 12, weight: weight ?? .regular)
        }
        
        /// Huge emoji font (128pt), designed for large emoji displays or expressive visuals.
        public static func hugeEmoji(weight: Font.Weight? = nil) -> Font {
            make(size: 128, weight: weight ?? .regular)
        }
        
        public static func make(size: CGFloat, weight: Font.Weight) -> Font {
            return Font.system(size: size, weight: weight)
        }
    }
}

extension DesignSystem.DSFont {
    public static func lineHeight(for font: Font) -> CGFloat {
        switch font {
        case DesignSystem.DSFont.extraLargeTitle():
            return 48
        case DesignSystem.DSFont.largeTitle():
            return 44
        case DesignSystem.DSFont.title():
            return 36
        case DesignSystem.DSFont.headline():
            return 32
        case DesignSystem.DSFont.subHeadline():
            return 28
        case DesignSystem.DSFont.body():
            return 24
        case DesignSystem.DSFont.callout():
            return 24
        case DesignSystem.DSFont.footnote():
            return 20
        case DesignSystem.DSFont.caption():
            return 20
        case DesignSystem.DSFont.hugeEmoji():
            return 136
        default:
            return 24
        }
    }
}
