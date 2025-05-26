// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UserBiometricsFeature",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "UserBiometricsFeature",
            targets: ["UserBiometricsFeature"]),
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
    ],
    targets: [
        .target(
            name: "UserBiometricsFeature",
            dependencies: [
                .product(
                    name: "CoreFoundational",
                    package: "CoreFoundational"
                ),
                .product(
                    name: "CoreHealthMaxModels",
                    package: "CoreHealthMaxModels"
                ),
                .product(
                    name: "CoreHealthKit",
                    package: "CoreHealthKit"
                )
            ]
        ),
        .testTarget(
            name: "UserBiometricsFeatureTests",
            dependencies: ["UserBiometricsFeature"]
        ),
    ]
)
