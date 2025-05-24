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
}

// MARK: - AppleHealthPermissionsViewModelling
extension AppleHealthPermissionsViewModel: AppleHealthPermissionsViewModelling {
    func requestAuthorization() async {
            guard HKHealthStore.isHealthDataAvailable() else {
                efficientPrint("Health data not available on this device.")
                return
            }
            self.requestStatus = .requesting
            do {
                try await healthStore.requestAuthorization(toShare: .init(), read: readTypes)
                requestStatus = .authorised
                efficientPrint("✅ Authorised Health access")
            } catch {
                efficientPrint("⛔️ Failed to authorise Health access: \(error.localizedDescription)")
                requestStatus = .denied
            }
    }
}
