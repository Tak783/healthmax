//
//  AppleHealthPermissionsViewModel.swift
//  QuizFeature
//
//  Created on 23/05/2025.
//

import CoreFoundational
import CoreSharedModels
import Foundation
import HealthKit

@MainActor
public final class AppleHealthPermissionsViewModel: ObservableObject {
    private let healthStore = HKHealthStore()
    
    @Published public var requestStatus = PermissionRequestStatus.unknown
    
    private lazy var readTypes: Set<HKObjectType> = {
        let quantityTypes: [HKQuantityTypeIdentifier] = [
            .bodyMass,
            .stepCount,
            .heartRate,
            .bloodGlucose,
            .activeEnergyBurned,
            .bodyTemperature,
            .bloodPressureSystolic,
            .bloodPressureDiastolic
        ]
        
        let quantityHKTypes: [HKObjectType] = quantityTypes.compactMap {
            HKQuantityType.quantityType(forIdentifier: $0)
        }
        
        let categoryHKTypes: [HKObjectType] = [
            HKCategoryType.categoryType(forIdentifier: .sleepAnalysis)
        ].compactMap { $0 }
        
        return Set(quantityHKTypes + categoryHKTypes)
    }()
    
    public init() {}
}

// MARK: - AppleHealthPermissionsViewModelling
extension AppleHealthPermissionsViewModel: AppleHealthPermissionsViewModelling {
    public func requestAuthorization() async {
        guard HKHealthStore.isHealthDataAvailable() else {
            safePrint("Health data not available on this device.")
            return
        }
        self.requestStatus = .requesting
        do {
            try await healthStore.requestAuthorization(toShare: .init(), read: readTypes)
            requestStatus = .authorised
            safePrint("✅ Authorised Health access")
        } catch {
            safePrint("⛔️ Failed to authorise Health access: \(error.localizedDescription)")
            requestStatus = .denied
        }
    }
}
