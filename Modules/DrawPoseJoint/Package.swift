// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DrawPoseJoint",
    platforms: [
        .iOS(.v14),
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "DrawPoseJoint",
            targets: ["DrawPoseJoint"]),
    ],
    targets: [        
        .target(
            name: "DrawPoseJoint"),
        .testTarget(
            name: "DrawPoseJointTests",
            dependencies: ["DrawPoseJoint"]),
    ]
)
