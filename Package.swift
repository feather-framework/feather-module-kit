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
        .library(name: "FeatherMigrationKit", targets: ["FeatherMigrationKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/feather-framework/feather-database", .upToNextMinor(from: "0.4.0")),
        .package(url: "https://github.com/feather-framework/feather-storage", .upToNextMinor(from: "0.5.0")),
        .package(url: "https://github.com/feather-framework/feather-mail", .upToNextMinor(from: "0.5.0")),
        .package(url: "https://github.com/feather-framework/feather-push", .upToNextMinor(from: "0.4.0")),
        .package(url: "https://github.com/feather-framework/feather-validation", .upToNextMinor(from: "0.1.0")),
        .package(url: "https://github.com/feather-framework/feather-access-control", .upToNextMinor(from: "0.2.0")),
        .package(url: "https://github.com/feather-framework/feather-scripts", .upToNextMinor(from: "0.1.0")),
    ],
    targets: [
        .target(
            name: "FeatherModuleKit",
            dependencies: [
                .product(name: "FeatherDatabase", package: "feather-database"),
                .product(name: "FeatherStorage", package: "feather-storage"),
                .product(name: "FeatherMail", package: "feather-mail"),
                .product(name: "FeatherPush", package: "feather-push"),
                .product(name: "FeatherValidation", package: "feather-validation"),
                .product(name: "FeatherACL", package: "feather-access-control"),
            ]
        ),
        .target(
            name: "FeatherMigrationKit",
            dependencies: [
                .product(name: "FeatherScripts", package: "feather-scripts"),
                .target(name: "FeatherModuleKit")
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
