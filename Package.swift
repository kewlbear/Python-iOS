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
        .binaryTarget(name: "libpython3", url: "https://github.com/kewlbear/Python-iOS/releases/download/v0.1.1-b20230423-090254/libpython3.xcframework.zip", checksum: "fff9f3874a12b725ac3dce406658fc99e75d885cc4356a1f1637490f657ec816"),
        .binaryTarget(name: "libssl", url: "https://github.com/kewlbear/Python-iOS/releases/download/v0.1.1-b20230423-090254/libssl.xcframework.zip", checksum: "e04b326f6779e567c5ba2f621f711762ddf7fb07f46eda5a5e70119836f5ca91"),
        .binaryTarget(name: "libcrypto", url: "https://github.com/kewlbear/Python-iOS/releases/download/v0.1.1-b20230423-090254/libcrypto.xcframework.zip", checksum: "c0b46f250be2051b6f847c811d31f4ff742bb08a90fc8c266ef61ec48293a3db"),
        .binaryTarget(name: "libffi", url: "https://github.com/kewlbear/Python-iOS/releases/download/v0.1.1-b20230423-090254/libffi.xcframework.zip", checksum: "c1ec3fe8a047b88809c74aba048737a3d05f86d61e061fcccfe970c872dbe6e5"),
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
