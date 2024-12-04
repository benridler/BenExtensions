// swift-tools-version: 6.0
import PackageDescription

let dependencies: [Target.Dependency] = [
    .product(name: "Algorithms", package: "swift-algorithms")
]

let package = Package(
    name: "BenExtensions",
    platforms: [
        .macOS(.v11),
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "BenExtensions",
            targets: ["BenExtensions"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-algorithms", .upToNextMajor(from: "1.2.0"))
    ],
    targets: [
        .target(
            name: "BenExtensions",
            dependencies: dependencies
        ),
        .testTarget(
            name: "BenExtensionsTests",
            dependencies: ["BenExtensions"]
        ),
    ]
)
