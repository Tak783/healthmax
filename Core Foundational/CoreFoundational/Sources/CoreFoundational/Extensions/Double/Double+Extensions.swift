//
//  Double+Extensions.swift
//  CoreFoundational
//
//  Created by Tak Mazarura on 24/05/2025.
//

import Foundation

extension Array where Element == Double {
    public var average: Double? {
        guard !isEmpty else { return nil }
        let total = reduce(0, +)
        return total / Double(count)
    }
}
