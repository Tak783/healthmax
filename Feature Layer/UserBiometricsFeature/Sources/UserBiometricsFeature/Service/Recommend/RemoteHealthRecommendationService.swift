//
//  RemoteHealthRecommendationService.swift
//  UserBiometricsFeature
//
//  Created on 02/06/2025.
//

import Firebase
import FirebaseAuth
import CoreHealthMaxModels
import Foundation
@preconcurrency import FirebaseFunctions

@MainActor
public struct RemoteHealthRecommendationService {
    private let functions = Functions.functions()

    public init() {}
}

// MARK: - HealthRecommendationServiceable
extension RemoteHealthRecommendationService: HealthRecommendationServiceable {
    public func getRecommendations(
        for metrics: [RemoteHealthMetric]
    ) async -> Result<[HealthImprovementRecommendation], Error> {
        await peformRequest(metrics, using: "getHealthRecommendations")
    }
}

// MARK: - Helpers
extension RemoteHealthRecommendationService {
    private func peformRequest(
        _ metrics: [RemoteHealthMetric],
        using functionName: String
    ) async -> Result<[HealthImprovementRecommendation], Error> {
        do {
            guard let userId = Auth.auth().currentUser?.uid else {
                return .failure(error("User not logged in", domain: "RemoteHealthRecommendationService"))
            }

            let data = try JSONEncoder().encode(metrics)
            guard let encodedMetrics = try JSONSerialization.jsonObject(with: data) as? [[String: Any]] else {
                throw error("Failed to encode metrics array.", domain: "RemoteHealthRecommendationService")
            }

            let payload: [String: Any] = [
                "userId": userId,
                "metrics": encodedMetrics
            ]

            let result = try await functions.httpsCallable(functionName).call(payload)
            return handleResult(result)
        } catch {
            return .failure(error)
        }
    }

    private func handleResult(_ result: HTTPSCallableResult) -> Result<[HealthImprovementRecommendation], Error> {
        guard let data = result.data as? [[String: Any]] else {
            return .failure(error("Invalid response format.", domain: "RemoteHealthRecommendationService"))
        }

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: data)
            let decoded = try JSONDecoder().decode([HealthImprovementRecommendation].self, from: jsonData)
            return .success(decoded)
        } catch {
            return .failure(error)
        }
    }

    private func error(_ message: String, domain: String) -> NSError {
        NSError(domain: domain, code: -1, userInfo: [NSLocalizedDescriptionKey: message])
    }
}

//{
//  "success": true,
//  "data": [
//    {
//      "currentValue": 5.58,
//      "actions": [],
//      "metricType": "height",
//      "summary": "Your height is recorded as 5 feet 7 inches."
//    },
//    {
//      "targetRange": [50, 68],
//      "currentValue": 65,
//      "targetTrend": "maintain",
//      "actions": [
//        "Maintain a balanced diet rich in fruits, vegetables, and lean proteins.",
//        "Engage in regular physical activity, such as 150 minutes of moderate aerobic exercise per week.",
//        "Monitor your weight regularly to ensure it remains within the healthy range."
//      ],
//      "metricType": "weight",
//      "summary": "Your weight is 65 kg, which is within a healthy range for your height."
//    }
//  ]
//}
