// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "QuizFeatureUI",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "QuizFeatureUI",
            targets: ["QuizFeatureUI"]),
    ],
    dependencies: [
        .package(
            name: "CoreFoundational",
            path: "../../Core Layer/CoreFoundational"
        ),
        .package(
            name: "CorePresentation",
            path: "../../Core Presentation/CorePresentation"
        ),
        .package(
            name: "CoreUIKit",
            path: "../../Core Presentation/CoreUIKit"
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
            name: "QuizFeature",
            path: "../Feature Layer/QuizFeature"
        )
    ],
    targets: [
        .target(
            name: "QuizFeatureUI",
            dependencies: [
                .product(
                    name: "CoreFoundational",
                    package: "CoreFoundational"
                ),
                .product(
                    name: "CorePresentation",
                    package: "CorePresentation"
                ),
                .product(
                    name: "CoreUIKit",
                    package: "CoreUIKit"
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
                    name: "QuizFeature",
                    package: "QuizFeature"
                )
            ]
        ),
        .testTarget(
            name: "QuizFeatureUITests",
            dependencies: [
                "QuizFeatureUI"
            ]
        ),
    ]
)
