// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CorePresentation",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "CorePresentation",
            targets: ["CorePresentation"]),
    ],
    dependencies: [
        .package(
            name: "CoreFoundational",
            path: "../Core Layer/CoreFoundational"
        )
    ],
    targets: [
        .target(
            name: "CorePresentation",
            dependencies: [
                .product(
                    name: "CoreFoundational",
                    package: "CoreFoundational"
                )
            ]
        ),
        .testTarget(
            name: "CorePresentationTests",
            dependencies: ["CorePresentation"]
        ),
    ]
)
