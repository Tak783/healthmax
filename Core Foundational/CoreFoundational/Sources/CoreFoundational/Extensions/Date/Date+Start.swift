//
//  Date+Start.swift
//  CoreFoundational
//
//  Created on 24/05/2025.
//

import Foundation

extension Date {
    public var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
    
    public var endOfDay: Date {
        Calendar.current.date(byAdding: .day, value: 1, to: startOfDay)!
    }
}
