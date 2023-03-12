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
        .binaryTarget(name: "libpython3", url: "https://github.com/kewlbear/Python-iOS/releases/download/v0.1.1-b20230312-012746/libpython3.xcframework.zip", checksum: "d8cc3fd6fa8d423472db262cdf8cc7dbf37905092214b1b4a60bdfe60e157117"),
        .binaryTarget(name: "libssl", url: "https://github.com/kewlbear/Python-iOS/releases/download/v0.1.1-b20230312-012746/libssl.xcframework.zip", checksum: "4fe35fe5cb115af686f1917e2e794a29cdd80b79b23cc1acd08bb20745db3e70"),
        .binaryTarget(name: "libcrypto", url: "https://github.com/kewlbear/Python-iOS/releases/download/v0.1.1-b20230312-012746/libcrypto.xcframework.zip", checksum: "53c404fb8bb312d7d0ff8b0d3b68869aa66b03e5008f326aad814401eac870ac"),
        .binaryTarget(name: "libffi", url: "https://github.com/kewlbear/Python-iOS/releases/download/v0.1.1-b20230312-012746/libffi.xcframework.zip", checksum: "0704567c97647f211be5cb4e527c8408e82f0266153ca5ba667f74757f983c01"),
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
