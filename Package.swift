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
        .binaryTarget(name: "libpython3", url: "https://github.com/kewlbear/Python-iOS/releases/download/v0.1.1-b20230423-043815/libpython3.xcframework.zip", checksum: "ee37b19e3dd8ddaa869f09aab0fe5c0514b3d051b9bdf68d94c154e897e1982d"),
        .binaryTarget(name: "libssl", url: "https://github.com/kewlbear/Python-iOS/releases/download/v0.1.1-b20230423-043815/libssl.xcframework.zip", checksum: "408a9b94c0bbbb4358838bd34e15799f12dece74dd21b8a60561887fb9dfc9d8"),
        .binaryTarget(name: "libcrypto", url: "https://github.com/kewlbear/Python-iOS/releases/download/v0.1.1-b20230423-043815/libcrypto.xcframework.zip", checksum: "c4ece329762cc90abe087eb192be2132619322b1ef760ebdcabbe2bfbcedd367"),
        .binaryTarget(name: "libffi", url: "https://github.com/kewlbear/Python-iOS/releases/download/v0.1.1-b20230423-043815/libffi.xcframework.zip", checksum: "cbc29901d9bba4ccc6813d7bc6719ab4d4fbe3b5dde8d7f599d544ddb14eac42"),
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
