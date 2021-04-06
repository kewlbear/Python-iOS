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
        .binaryTarget(name: "libpython3", url: "https://github.com/kewlbear/Python-iOS/releases/download/0.0.20210406064152/libpython3.xcframework.zip", checksum: "d0e3adec6421de46615a8678d02b1da1c5bfa6ba4b8235998e604b1a7af5c05d"),
        .binaryTarget(name: "libssl", url: "https://github.com/kewlbear/Python-iOS/releases/download/0.0.20210406064152/libssl.xcframework.zip", checksum: "05f90a46ea222f086174ed9780485f03f67ec621ee2d25c2007b6194ffad385b"),
        .binaryTarget(name: "libcrypto", url: "https://github.com/kewlbear/Python-iOS/releases/download/0.0.20210406064152/libcrypto.xcframework.zip", checksum: "82d445e746e100b4ed944ae50bb158b183ed89650bcf7496544f53608db117eb"),
        .binaryTarget(name: "libffi", url: "https://github.com/kewlbear/Python-iOS/releases/download/0.0.20210406064152/libffi.xcframework.zip", checksum: "38497a72db26b09b90eaa58bbe43f66e60f518869fff0b01aa199974cc18e90c"),
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
