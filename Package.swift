// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Python-iOS",
    platforms: [.iOS(.v9)],
    products: [
        .library(
            name: "Python-iOS",
            targets: [ // order matters!
                "LinkPython",
                "libpython3", "libssl", "libcrypto", "libffi",
                "PythonSupport",
            ]),
    ],
    targets: [
        .binaryTarget(name: "libpython3", url: "https://github.com/kewlbear/Python-iOS/releases/download/v0.1.1-b20230423-053002/libpython3.xcframework.zip", checksum: "ea0378113a1fbd12b3a7bbea43a99c13c85b997674e2b41590e6e63e625e784c"),
        .binaryTarget(name: "libssl", url: "https://github.com/kewlbear/Python-iOS/releases/download/v0.1.1-b20230423-053002/libssl.xcframework.zip", checksum: "93f81d4b914c88a37cf2d3e391308488e8c514197d3e7bb482ca51b262a3a2d6"),
        .binaryTarget(name: "libcrypto", url: "https://github.com/kewlbear/Python-iOS/releases/download/v0.1.1-b20230423-053002/libcrypto.xcframework.zip", checksum: "2565f50faed2320f0bb9fa564ac0c1c046697e4b7226e960cd0eb9115c678431"),
        .binaryTarget(name: "libffi", url: "https://github.com/kewlbear/Python-iOS/releases/download/v0.1.1-b20230423-053002/libffi.xcframework.zip", checksum: "95656a003e34b2237f3712be55438cc0ee2f9bb7c523fd9b375a93ed912de579"),
        .target(name: "LinkPython",
                dependencies: [
                    "libpython3",
                    "libssl",
                    "libcrypto",
                    "libffi",
                ],
                linkerSettings: [
                    .linkedLibrary("z"),
                    .linkedLibrary("sqlite3"),
                ]
        ),
        .target(name: "PythonSupport",
                dependencies: ["LinkPython"],
                resources: [.copy("lib")]),
        .testTarget(
            name: "PythonTests",
            dependencies: ["PythonSupport"]),
    ]
)
