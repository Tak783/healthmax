// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CoreHealthKit",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "CoreHealthKit",
            targets: ["CoreHealthKit"]),
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
    ],
    targets: [
        .target(
            name: "CoreHealthKit",
            dependencies: [
                .product(
                    name: "CoreFoundational",
                    package: "CoreFoundational"
                ),
                .product(
                    name: "CoreHealthMaxModels",
                    package: "CoreHealthMaxModels"
                )
            ]
        ),
        .testTarget(
            name: "CoreHealthKitTests",
            dependencies: ["CoreHealthKit"]
        ),
    ]
)
