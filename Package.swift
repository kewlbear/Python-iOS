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
        .binaryTarget(name: "libpython3", url: "https://github.com/kewlbear/Python-iOS/releases/download/0.0.1-20210331/libpython3.xcframework.zip", checksum: "f45a4efeefad5d282c7eb4ac1d7252e8ad023991e151b48b5ca131989a30a2c3"),
        .binaryTarget(name: "libssl", url: "https://github.com/kewlbear/Python-iOS/releases/download/0.0.1-20210331/libssl.xcframework.zip", checksum: "18d6754f053c5923fb9ef7c23339e1e2ab7cd3b6463aab24a05ee70999cbf90e"),
        .binaryTarget(name: "libcrypto", url: "https://github.com/kewlbear/Python-iOS/releases/download/0.0.1-20210331/libcrypto.xcframework.zip", checksum: "4db7e03555a66e1141246bbb7c5c0bd7b8aeec3c67aed3c05fcea28c1e263ebb"),
        .binaryTarget(name: "libffi", url: "https://github.com/kewlbear/Python-iOS/releases/download/0.0.1-20210331/libffi.xcframework.zip", checksum: "207daa9ba776076bce888cfe1fe9f0bd76aafe15a6f8b4e0bc74bd08254a206b"),
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
