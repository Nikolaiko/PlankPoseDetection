// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ArticlesProvider",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "ArticlesProvider",
            targets: ["ArticlesProvider"]
        ),
//        .library(
//          name: "ArticlesProviderLive",
//          targets: ["ArticlesProviderLive"]
//        ),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.3.0")
    ],
    targets: [
        .target(
            name: "ArticlesProvider",
            dependencies: [
              .product(name: "Dependencies", package: "swift-dependencies")
            ],
            resources: [
                .process("Resources")
            ]
        ),
        .testTarget(
            name: "ArticlesProviderTests",
            dependencies: [
                "ArticlesProvider",
                //"ArticlesProviderLive"
            ]
        ),
//        .target(
//          name: "ArticlesProviderLive",
//          dependencies: [
//            .product(name: "Dependencies", package: "swift-dependencies"),
//            "ArticlesProvider"
//          ],
//          resources: [
//            .process("Resources")
//          ]
//        )
    ]
)
