//
//  AppleHealthPermissionsViewModel.swift
//  QuizFeature
//
//  Created by Tak Mazarura on 23/05/2025.
//

import CoreFoundational
import Foundation
import HealthKit

@MainActor
final class AppleHealthPermissionsViewModel: ObservableObject {
    private let healthStore = HKHealthStore()
    
    @Published var requestStatus = HealthPermissionRequestStatus.unknown
    
    private lazy var readTypes: Set<HKObjectType> =  {
        let types: [HKQuantityType?] = [
            HKQuantityType.quantityType(forIdentifier: .stepCount),
            HKQuantityType.quantityType(forIdentifier: .bodyMass),
            HKQuantityType.quantityType(forIdentifier: .heartRate),
            HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)
        ]
        return Set(types.compactMap { $0 as HKObjectType? })
    }()
    
    private lazy var shareTypes: Set<HKSampleType> = {
        let types: [HKQuantityType?] = [
            HKQuantityType.quantityType(forIdentifier: .bodyMass)
        ]
        return Set(types.compactMap { $0 as HKSampleType? })
    }()
}

// MARK: - AppleHealthPermissionsViewModelling
extension AppleHealthPermissionsViewModel: AppleHealthPermissionsViewModelling {
    func requestAuthorization() {
        Task { [weak self] in
            guard let self else {
                return
            }
            guard HKHealthStore.isHealthDataAvailable() else {
                efficientPrint("Health data not available on this device.")
                return
            }
            self.requestStatus = .requesting
            do {
                try await self.healthStore.requestAuthorization(toShare: shareTypes, read: readTypes)
                self.requestStatus = .authorised
            } catch {efficientPrint("Failed to authorise Health access: \(error.localizedDescription)")
                self.requestStatus = .denied
            }
        }
    }
}
