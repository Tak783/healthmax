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
            url: "https://github.com/firebase/firebase-ios-sdk.git",
            .upToNextMajor(from: "10.24.0")
        ),
        .package(
            url: "https://github.com/google/GoogleSignIn-iOS",
            .upToNextMajor(from: "7.1.0")
        ),
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
                    name: "GoogleSignIn",
                    package: "GoogleSignIn-iOS"
                ),
                .product(
                    name: "FirebaseAnalytics",
                    package: "firebase-ios-sdk"
                ),
                .product(
                    name: "FirebaseAuth",
                    package: "firebase-ios-sdk"
                ),
                .product(
                    name: "FirebaseFirestore",
                    package: "firebase-ios-sdk"
                ),
                .product(
                    name: "FirebaseFunctions",
                    package: "firebase-ios-sdk"
                ),
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
            dependencies: [
                "UserBiometricsFeature",
                "CoreHealthMaxModels"
            ]
        ),
    ]
)
