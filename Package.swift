// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Python-iOS",
    platforms: [.iOS(.v9)],
    products: [
        .library(
            name: "Python-iOS",
            targets: ["Symbols", "Python", "BZip2", "SSL", "Crypto", "XZ", "Resources"]),
    ],
    dependencies: [
        .package(url: "https://github.com/alloyapple/CSqlite3.git", .branch("master")),
    ],
    targets: [
        .binaryTarget(name: "Python", url: "https://github.com/kewlbear/Python-iOS/releases/download/0.0.1/Python.xcframework.zip", checksum: "7b5b216986a1a81b6d12ae3cab2e8d99ef2cd9e6ad593ed50db48cbb8d68fe0e"),
        .binaryTarget(name: "BZip2", url: "https://github.com/kewlbear/Python-iOS/releases/download/0.0.1/BZip2.xcframework.zip", checksum: "3ef7ea97370492aba685b1dd03fecc7f19e292e28a303abc43e6324b96cd19ff"),
        .binaryTarget(name: "SSL", url: "https://github.com/kewlbear/Python-iOS/releases/download/0.0.1/SSL.xcframework.zip", checksum: "373de27ba1c9cc1f35fe38ba98c43c48de1ccef1bcf5cb31e0f6fdaa0171083a"),
        .binaryTarget(name: "Crypto", url: "https://github.com/kewlbear/Python-iOS/releases/download/0.0.1/Crypto.xcframework.zip", checksum: "98f7d56117430edfe31e7b19af87745e4738a005156c13a82a05950fe3187f60"),
        .binaryTarget(name: "XZ", url: "https://github.com/kewlbear/Python-iOS/releases/download/0.0.1/XZ.xcframework.zip", checksum: "039fe28d39b6c2217f33cb50032aa8f90673e484e99edf0dbe56be47856f9994"),
        .target(name: "Resources", dependencies: ["Symbols"], resources: [.copy("lib")]),
        .target(name: "Symbols", dependencies: ["Python", "BZip2", "SSL", "Crypto", "XZ", "CSqlite3", "Clibz"]),
        .target(name: "Clibz", linkerSettings: [LinkerSetting.linkedLibrary("z")]),
        .testTarget(
            name: "PythonTests",
            dependencies: ["Resources"]),
    ]
)
