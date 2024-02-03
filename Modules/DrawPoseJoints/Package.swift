// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DrawPoseJoints",
    platforms: [
        .iOS(.v14),
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "DrawPoseJoints",
            targets: ["DrawPoseJoints"]),
    ],
    targets: [
        .target(
            name: "DrawPoseJoints"),
        .testTarget(
            name: "DrawPoseJointsTests",
            dependencies: ["DrawPoseJoints"]),
    ]
)
