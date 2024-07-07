// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
let package = Package(
    name: "VideoPlayer",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "AppVideoPlayer",
            targets: ["AppVideoPlayer"]
        ),
        .library(
            name: "AppVideoPlayerLive",
            targets: ["AppVideoPlayerLive"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.3.0")
    ],
    targets: [
        .target(
            name: "AppVideoPlayer",
            dependencies: [.product(name: "Dependencies", package: "swift-dependencies")],
            resources: [.process("Resources")]
        ),
        .target(
            name: "AppVideoPlayerLive",
            dependencies: [
                .product(name: "Dependencies", package: "swift-dependencies"),
                "AppVideoPlayer"
            ]
        ),
        .testTarget(
            name: "VideoPlayerTests",
            dependencies: ["AppVideoPlayer"]),
    ]
)
