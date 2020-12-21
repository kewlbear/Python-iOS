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
        .binaryTarget(name: "Python", path: "Frameworks/Python.xcframework"),
        .binaryTarget(name: "BZip2", path: "Frameworks/BZip2.xcframework"),
        .binaryTarget(name: "SSL", path: "Frameworks/SSL.xcframework"),
        .binaryTarget(name: "Crypto", path: "Frameworks/Crypto.xcframework"),
        .binaryTarget(name: "XZ", path: "Frameworks/XZ.xcframework"),
        .target(name: "Resources", dependencies: ["Symbols"], resources: [.copy("lib")]),
        .target(name: "Symbols", dependencies: ["Python", "BZip2", "SSL", "Crypto", "XZ", "CSqlite3", "Clibz"]),
        .target(name: "Clibz", linkerSettings: [LinkerSetting.linkedLibrary("z")]),
        .testTarget(
            name: "PythonTests",
            dependencies: ["Resources"]),
    ]
)
