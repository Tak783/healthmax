// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CoreHealthMaxModels",
    platforms: [
        .iOS(.v17),
        .watchOS(.v10)
    ],
    products: [
        .library(
            name: "CoreHealthMaxModels",
            targets: ["CoreHealthMaxModels"]
        ),
    ],
    dependencies: [
        .package(
            name: "CoreFoundational",
            path: "../../Core Layer/CoreFoundational"
        ),
        .package(
            name: "CoreSharedModels",
            path: "../CoreSharedModels"
        )
    ],
    targets: [
        .target(
            name: "CoreHealthMaxModels",
            dependencies: [
                .product(
                    name: "CoreFoundational",
                    package: "CoreFoundational"
                ),
                .product(
                    name: "CoreSharedModels",
                    package: "CoreSharedModels"
                )
            ]
        ),
        .testTarget(
            name: "CoreHealthMaxModelsTests",
            dependencies: ["CoreHealthMaxModels"]
        ),
    ]
)
