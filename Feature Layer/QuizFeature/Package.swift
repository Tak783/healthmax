// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "QuizFeature",
    platforms: [
        .iOS(.v17),
        .watchOS(.v10)
    ],
    products: [
        .library(
            name: "QuizFeature",
            targets: ["QuizFeature"]),
    ],
    dependencies: [
        .package(
            name: "CoreFoundational",
            path: "../../Core Layer/CoreFoundational"
        ),
        .package(
            name: "CoreHealthMaxModels",
            path: "../Core HealthMax/CoreHealthMaxModels"
        ),
        .package(
            name: "CoreHealthKit",
            path: "../CoreHealthKit"
        ),
        .package(
            name: "UserBiometricsFeature",
            path: "../UserBiometricsFeature"
        )
    ],
    targets: [
        .target(
            name: "QuizFeature",
            dependencies: [
                .product(
                    name: "CoreFoundational",
                    package: "CoreFoundational"
                ),
                .product(
                    name: "CoreHealthKit",
                    package: "CoreHealthKit"
                ),
                .product(
                    name: "CoreHealthMaxModels",
                    package: "CoreHealthMaxModels"
                ),
                .product(
                    name: "UserBiometricsFeature",
                    package: "UserBiometricsFeature"
                )
            ]
        ),
        .testTarget(
            name: "QuizFeatureTests",
            dependencies: [
                "QuizFeature"
            ]
        ),
    ]
)
