// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PoseEstimation",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "PoseEstimation",
            targets: ["PoseEstimation"]),
        .library(
            name: "PoseEstimationLive",
            targets: ["PoseEstimationLive"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.3.0"),
        .package(path: "./AppDevPackage")
    ],
    targets: [
        .target(
            name: "PoseEstimation",
            dependencies: [.product(name: "Dependencies", package: "swift-dependencies")]
        ),
        .target(
            name: "PoseEstimationLive",
            dependencies: [
                .product(name: "Dependencies", package: "swift-dependencies"),
                .product(name: "Math", package: "AppDevPackage"),
                "PoseEstimation"
            ]
        ),
        .testTarget(
            name: "PoseEstimationTests",
            dependencies: ["PoseEstimation"]),
    ]
)
