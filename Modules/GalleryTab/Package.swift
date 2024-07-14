// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GalleryTab",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "GalleryTab",
            targets: ["GalleryTab"]),
    ],
    dependencies: [
        .package(path: "../PoseDetection"),
        .package(path: "../PoseEstimation"),
        .package(path: "../VideoPlayer"),
        .package(path: "../AppFilesManager"),
        .package(path: "../DrawPoseJoint"),
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.9.3")
    ],
    targets: [
        .target(
            name: "GalleryTab",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                .product(name: "PoseDetection", package: "PoseDetection"),
                .product(name: "AppVideoPlayer", package: "VideoPlayer"),
                .product(name: "AppFilesManager", package: "AppFilesManager"),
                .product(name: "DrawPoseJoint", package: "DrawPoseJoint"),
                .product(name: "PoseEstimation", package: "PoseEstimation"),
            ]
        ),
        .testTarget(
            name: "GalleryTabTests",
            dependencies: ["GalleryTab"]),
    ]
)
