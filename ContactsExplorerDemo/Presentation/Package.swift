// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Presentation",
    platforms: [.iOS(.v17), .watchOS(.v6)],
    products: [
        .singleTargetLibrary(name: "DesignSystem"),
        
        .navigator(.app),
        .navigator(.contacts),
        
        .feature(.contacts),
    ],
    dependencies: [
        .package(path: "../Utilities"),
        .package(path: "../Data"),
        .package(path: "../Domain"),
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.23.1"),
        .package(url: "https://github.com/EyalKatz24/Localized", from: "1.3.0")
    ],
    targets: [
        .target(
            name: "DesignSystem",
            dependencies: [
                "InternalUtilities",
                .product(name: "Utilities", package: "Utilities"),
                .product(name: "Models", package: "Data"),
                .product(name: "Domain", package: "Domain"),
            ]
        ),
    
        .target(
            name: "InternalUtilities",
            dependencies: [
                .product(name: "Utilities", package: "Utilities"),
                .product(name: "Models", package: "Data"),
                .product(name: "Domain", package: "Domain"),
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                .product(name: "Localized", package: "Localized")
            ]
        ),
        
        .testTarget(
            name: "PresentationTests",
            dependencies: [
                .product(name: "Utilities", package: "Utilities"),
                .product(name: "Models", package: "Data"),
                .product(name: "Domain", package: "Domain")
            ]
        )
    ]
)

// MARK: - Navigators

enum Navigator: String {
    case app = "App"
    case contacts = "Contacts"
    
    var name: String { "\(rawValue)Navigator" }
    
    var path: String { "Sources/Navigators/\(rawValue)" }
}

let navigators: [PackageDescription.Target] = [
    .navigator(.app,
        features: [],
        navigators: [
            .contacts
        ]
    ),
    .navigator(.contacts,
        features: [],
        navigators: []
    ),
]

for target in navigators {
    target.dependencies.append(contentsOf: [
        "DesignSystem",
        "InternalUtilities",
        .product(name: "Utilities", package: "Utilities"),
        .product(name: "Models", package: "Data"),
        .product(name: "Domain", package: "Domain"),
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
    ])
}

// MARK: - Features

enum Feature: String, CaseIterable {
    case contacts = "Contacts"
    
    var name: String { "\(rawValue)Feature" }
    
    var path: String { "Sources/Features/\(rawValue)" }
}

let features: [PackageDescription.Target] = Feature.allCases.map {
    .feature($0)
}

for target in features {
    target.dependencies.append(contentsOf: [
        "DesignSystem",
        "InternalUtilities",
        .product(name: "Utilities", package: "Utilities"),
        .product(name: "Models", package: "Data"),
        .product(name: "Domain", package: "Domain"),
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
    ])
}

package.targets.append(contentsOf: features + navigators)

// MARK: - Extensions

extension Product {
    static func singleTargetLibrary(name: String) -> Product {
        .library(name: name, targets: [name])
    }
    
    static func navigator(_ navigator: Navigator) -> Product {
        .library(name: navigator.name, targets: [navigator.name])
    }
    
    static func feature(_ feature: Feature) -> Product {
        .library(name: feature.name, targets: [feature.name])
    }
}

extension Target {
    static func navigator(_ navigator: Navigator, features: [Feature], navigators: [Navigator]) -> Target {
        let featureDependencies: [Dependency] = features.map { .byName(name: $0.name) }
        let navigatorDependencies: [Dependency] = navigators.map { .byName(name: $0.name) }
        return .target(
            name: navigator.name,
            dependencies: featureDependencies + navigatorDependencies,
            path: navigator.path
        )
    }
    
    static func feature(_ feature: Feature) -> Target {
        .target(name: feature.name, path: feature.path)
    }
}
