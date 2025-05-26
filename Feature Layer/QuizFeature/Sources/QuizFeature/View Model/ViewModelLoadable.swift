//
//  ViewModelLoadable.swift
//  CorePresentation
//
//  TODO: - Move this and the duplicates elswhere into a new package below FeatureLayer to support platform agnostic presentation  
//
//  Created on 23/05/2025.
//

import Foundation

@MainActor
internal protocol ViewModelLoadable: AnyObject {
    var isLoading: Bool { get set }
    
    func setIsLoading(_ isLoading: Bool)
}

// MARK: - Default Implementation
extension ViewModelLoadable {
    @MainActor
    internal func setIsLoading(_ isLoading: Bool) {
        DispatchQueue.main.async {
            self.isLoading = isLoading
        }
    }
}
