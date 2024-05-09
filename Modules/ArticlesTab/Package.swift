// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ArticlesTab",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "ArticlesTab",
            targets: ["ArticlesTab"])
    ],
    dependencies: [
        .package(path: "../ArticlesProvider"),
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.9.2")
    ],
    targets: [
        .target(
            name: "ArticlesTab",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                .product(name: "ArticlesProvider", package: "ArticlesProvider")
            ]
        ),
        .testTarget(
            name: "ArticlesTabTests",
            dependencies: ["ArticlesTab"])
    ]
)
