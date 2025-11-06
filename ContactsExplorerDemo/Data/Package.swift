// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
let package = Package(
    name: "Data",
    platforms: [.iOS(.v17), .watchOS(.v6)],
    products: [
        .library(name: "Models", targets: ["Models"]),
        .library(name: "Services", targets: ["Services"])
    ],
    dependencies: [
        .package(path: "../Utilities"),
        .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.10.0"),
        .package(url: "https://github.com/pointfreeco/swift-identified-collections", from: "1.1.1"),
        .package(url: "https://github.com/pointfreeco/swift-sharing", from: "2.7.4")
    ],
    targets: [
        .target(
            name: "Models",
            dependencies: [
                .product(name: "Utilities", package: "Utilities"),
                .product(name: "Dependencies", package: "swift-dependencies"),
                .product(name: "IdentifiedCollections", package: "swift-identified-collections"),
                .product(name: "Sharing", package: "swift-sharing"),
            ]
        ),
        
        .target(
            name: "Services",
            dependencies: [
                "Models",
                .product(name: "Utilities", package: "Utilities"),
                .product(name: "Dependencies", package: "swift-dependencies")
            ]
        )
    ]
)
