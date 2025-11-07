// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Domain",
    platforms: [.iOS(.v17), .watchOS(.v6)],
    products: [
        .library(
            name: "Domain",
            targets: ["Domain"]
        ),
    ],
    dependencies: [
        .package(path: "../Utilities"),
        .package(path: "../Data"),
        .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.10.0"),
        .package(url: "https://github.com/pointfreeco/swift-perception", from: "2.0.9"),
        .package(url: "https://github.com/pointfreeco/swift-sharing", from: "2.7.4")
    ],
    targets: [
        .target(
            name: "Domain",
            dependencies: [
                .product(name: "Utilities", package: "Utilities"),
                .product(name: "Models", package: "Data"),
                .product(name: "Services", package: "Data"),
                .product(name: "Dependencies", package: "swift-dependencies")
            ]
        ),
        .testTarget(
            name: "DomainTests",
            dependencies: [
                "Domain",
                .product(name: "Utilities", package: "Utilities"),
                .product(name: "Models", package: "Data"),
                .product(name: "Services", package: "Data"),
                .product(name: "Dependencies", package: "swift-dependencies"),
                .product(name: "Perception", package: "swift-perception"),
                .product(name: "Sharing", package: "swift-sharing")
            ]
        )
    ]
)
