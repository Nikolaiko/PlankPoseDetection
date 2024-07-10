// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DrawPoseJoint",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "DrawPoseJoint", targets: ["DrawPoseJoint"])
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.3.0"),
        .package(path: "./AppDevPackage")
    ],
    targets: [
        .target(
            name: "DrawPoseJoint",
            dependencies: [
                .product(name: "Dependencies", package: "swift-dependencies"),
                .product(name: "CommonModels", package: "AppDevPackage")
            ]
        ),
        .testTarget(
            name: "DrawPoseJointTests",
            dependencies: ["DrawPoseJoint"])
    ]
)
