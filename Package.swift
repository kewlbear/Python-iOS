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
        .binaryTarget(name: "libpython3", url: "https://github.com/kewlbear/Python-iOS/releases/download/0.0.20210412042738/libpython3.xcframework.zip", checksum: "1d87c807880af47a166578ddf3dba8b656c5fe8d9c7ad25db894bc9619292445"),
        .binaryTarget(name: "libssl", url: "https://github.com/kewlbear/Python-iOS/releases/download/0.0.20210412042738/libssl.xcframework.zip", checksum: "a2e5832c942adfe5c5f2c23859d7dcdd38f7cc95051d90720e9b2bdac4fc32e5"),
        .binaryTarget(name: "libcrypto", url: "https://github.com/kewlbear/Python-iOS/releases/download/0.0.20210412042738/libcrypto.xcframework.zip", checksum: "dc83a0b4261b062d1e5a6bb2fe15d71c875a5fc95a5f591fe021435971dac6b2"),
        .binaryTarget(name: "libffi", url: "https://github.com/kewlbear/Python-iOS/releases/download/0.0.20210412042738/libffi.xcframework.zip", checksum: "9bdfebd8fcbd5bf8ac30916b6846d631d959ca3b7c867077d4c03af0329d8395"),
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
