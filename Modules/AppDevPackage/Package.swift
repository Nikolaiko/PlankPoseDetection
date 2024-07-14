// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AppDevPackage",
    platforms: [.iOS(.v14), .macOS(.v13)],
    products: [
        .library(name: "Math", targets: ["Math"]),
        .library(name: "CommonModels", targets: ["CommonModels"])
    ],
    targets: [
        .target(name: "Math"),
        .target(name: "CommonModels"),
        .testTarget(name: "MathTests", dependencies: ["Math"])
    ]
)
