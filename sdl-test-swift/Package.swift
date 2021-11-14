// swift-tools-version:5.5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "sdltest-swift",
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/ctreffs/SwiftSDL2.git", from: "1.2.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .executableTarget(
            name: "sdltest-swift",
            dependencies: [
              .product(name: "SDL2", package: "SwiftSDL2")
            ]),
        .testTarget(
            name: "sdltest-swiftTests",
            dependencies: ["sdltest-swift"]),
    ]
)
