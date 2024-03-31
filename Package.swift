// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "feather-module-kit",
    platforms: [
        .macOS(.v14),
        .iOS(.v17),
        .tvOS(.v17),
        .watchOS(.v10),
        .visionOS(.v1),
    ],
    products: [
        .library(name: "FeatherModuleKit", targets: ["FeatherModuleKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/feather-framework/feather-relational-database", .upToNextMinor(from: "0.2.0")),
        .package(url: "https://github.com/feather-framework/feather-database-kit", .upToNextMinor(from: "0.7.0")),
        .package(url: "https://github.com/feather-framework/feather-validation", .upToNextMinor(from: "0.1.0")),
        .package(url: "https://github.com/feather-framework/feather-access-control", .upToNextMinor(from: "0.2.0")),
    ],
    targets: [
        .target(
            name: "FeatherModuleKit",
            dependencies: [
                .product(name: "FeatherRelationalDatabase", package: "feather-relational-database"),
                .product(name: "FeatherValidation", package: "feather-validation"),
                .product(name: "DatabaseQueryKit", package: "feather-database-kit"),
                .product(name: "FeatherACL", package: "feather-access-control"),
            ]
        ),
        .testTarget(
            name: "FeatherModuleKitTests",
            dependencies: [
                .target(name: "FeatherModuleKit")
            ]
        ),
    ]
)
