// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Math",
    products: [
        .library(
            name: "LineMath",
            targets: ["LineMath"]
        ),
        .library(
            name: "PointMath",
            targets: ["PointMath"]
        )
    ],
    targets: [
        .target(name: "LineMath", dependencies: [.targetItem(name: "Model", condition: nil)]),
        .target(name: "PointMath", dependencies: [.targetItem(name: "Model", condition: nil)]),
        .target(name: "Model"),
        .target(name: "TestValues"),

        .testTarget(name: "LineMathTests", dependencies: ["LineMath", "TestValues"]),
        .testTarget(name: "PointMathTests", dependencies: ["PointMath", "TestValues"])
    ]
)
