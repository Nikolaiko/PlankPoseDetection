// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AppFilesManager",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "AppFilesManager",
            targets: ["AppFilesManager"]
        ),
        .library(
            name: "AppFilesManagerLive",
            targets: ["AppFilesManagerLive"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.3.0")
    ],
    targets: [
        .target(
            name: "AppFilesManager",
            dependencies: [
                .product(name: "Dependencies", package: "swift-dependencies")
            ]
        ),
        .target(
            name: "AppFilesManagerLive",
            dependencies: [
                .product(name: "Dependencies", package: "swift-dependencies"),
                "AppFilesManager"
            ]
        ),
        .testTarget(
            name: "AppFilesManagerTests",
            dependencies: ["AppFilesManager"])
    ]
)
