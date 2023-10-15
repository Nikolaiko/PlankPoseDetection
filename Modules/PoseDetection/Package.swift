// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PoseDetection",
    platforms: [
        .iOS(.v14),
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "PoseDetection",
            targets: ["PoseDetection"])
    ],
    targets: [
        .target(
            name: "PoseDetection"),
        .testTarget(
            name: "PoseDetectionTests",
            dependencies: ["PoseDetection"])
    ]
)
