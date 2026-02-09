// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "DidiFactory",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v8),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "DidiFactory",
            targets: ["DidiFactory"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/antoniopantaleo/didi.git",
            from: "2.0.0"
        ),
        .package(
            url: "https://github.com/hmlongco/Factory.git",
            from: "2.0.0"
        )
    ],
    targets: [
        .target(
            name: "DidiFactory",
            dependencies: [
                .product(name: "Didi", package: "didi"),
                .product(name: "FactoryKit", package: "Factory")
            ],
            swiftSettings: .approachableConcurrency
        ),
        .testTarget(
            name: "DidiFactoryTests",
            dependencies: [
                "DidiFactory",
                .product(name: "Didi", package: "didi"),
                .product(name: "FactoryKit", package: "Factory")
            ],
            swiftSettings: .approachableConcurrency
        ),
    ]
)

fileprivate extension [SwiftSetting] {
    static var approachableConcurrency: [SwiftSetting] {
        [
            .defaultIsolation(MainActor.self),
            .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
            .enableUpcomingFeature("InferIsolatedConformances")
        ]
    }
}
