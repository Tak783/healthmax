//
//  Double+Extensions.swift
//  CoreFoundational
//
//  Created on 24/05/2025.
//

import Foundation

extension Double {
    /// Converts feet + inches into a decimal feet value.
    public static func combinedHeightInFeet(feet: Int, inches: Int) -> Double {
        return Double(feet) + Double(inches) / 12.0
    }

    /// Converts a decimal feet value (e.g. 5.75) to (feet, inches).
    public static func toFeet(_ decimal: Double) -> (feet: Int, inches: Int) {
        let feet = Int(decimal)
        let inchesDecimal = (decimal - Double(feet)) * 12.0
        let inches = Int(inchesDecimal.rounded())
        return (feet, inches)
    }
}

extension Array where Element == Double {
    public var average: Double? {
        guard !isEmpty else { return nil }
        let total = reduce(0, +)
        return total / Double(count)
    }
}

