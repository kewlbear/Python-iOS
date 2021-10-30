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
        .binaryTarget(name: "libpython3", url: "https://github.com/kewlbear/Python-iOS/releases/download/0.0.20211030082633/libpython3.xcframework.zip", checksum: "fcf539304710ca15b61793937e63491d5cbf96c208b48dc1c1bf9aebd17d0288"),
        .binaryTarget(name: "libssl", url: "https://github.com/kewlbear/Python-iOS/releases/download/0.0.20211030082633/libssl.xcframework.zip", checksum: "ca16c728275205dbd00df411874f00ce29348868fb66f747dd08f104bcb73112"),
        .binaryTarget(name: "libcrypto", url: "https://github.com/kewlbear/Python-iOS/releases/download/0.0.20211030082633/libcrypto.xcframework.zip", checksum: "ab8106637f7ad7259c6b1af324f8c5eb9f99f8c20529050ffa3c66d8d3cffc91"),
        .binaryTarget(name: "libffi", url: "https://github.com/kewlbear/Python-iOS/releases/download/0.0.20211030082633/libffi.xcframework.zip", checksum: "4f5991483df1393ae3bca1365c21594a6b02a61fa328139cbfdfd21a87b2014a"),
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
