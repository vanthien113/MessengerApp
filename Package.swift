// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MessengerApp",
    platforms: [
        .macOS(.v11)
    ],
    products: [
        .executable(
            name: "MessengerApp",
            targets: ["MessengerApp"]),
    ],
    targets: [
        .executableTarget(
            name: "MessengerApp",
            dependencies: []),
    ]
)
