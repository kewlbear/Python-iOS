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
        .binaryTarget(name: "libpython3", url: "https://github.com/kewlbear/Python-iOS/releases/download/0.0.20210412042656/libpython3.xcframework.zip", checksum: "85aba07c6d968f3b01c968c5f69d4b79ffde0dcbfa45265ed9288f262f3666b8"),
        .binaryTarget(name: "libssl", url: "https://github.com/kewlbear/Python-iOS/releases/download/0.0.20210412042656/libssl.xcframework.zip", checksum: "bafcc38597d44f6e4441a3649b1f050a0f50ecd6eae39ac30591022c0bcccfb8"),
        .binaryTarget(name: "libcrypto", url: "https://github.com/kewlbear/Python-iOS/releases/download/0.0.20210412042656/libcrypto.xcframework.zip", checksum: "7699064042890de1eac1fad45843fadea10739e73ae4f064ed19bfad28dcce2b"),
        .binaryTarget(name: "libffi", url: "https://github.com/kewlbear/Python-iOS/releases/download/0.0.20210412042656/libffi.xcframework.zip", checksum: "93d243e494d2d19f83581f1dadc1f33d51dd58d918e0cbf8c6d298d4f01bb98a"),
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
