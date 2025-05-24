//
//  ViewModelLoadable.swift
//  CorePresentation
//
//  Created on 23/05/2025.
//


import Foundation

@MainActor
public protocol ViewModelLoadable: AnyObject {
    var isLoading: Bool { get set }
    
    func setIsLoading(_ isLoading: Bool)
}

// MARK: - Default Implementation
extension ViewModelLoadable {
    @MainActor
    public func setIsLoading(_ isLoading: Bool) {
        DispatchQueue.main.async {
            self.isLoading = isLoading
        }
    }
}
