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
        .binaryTarget(name: "libpython3", url: "https://github.com/kewlbear/Python-iOS/releases/download/0.0.20210401053451/libpython3.xcframework.zip", checksum: "7e9660ddf41efacb2b9f95cd6c209cdf31431f9fb3ee233aa8af669d7d5d12bd"),
        .binaryTarget(name: "libssl", url: "https://github.com/kewlbear/Python-iOS/releases/download/0.0.20210401053451/libssl.xcframework.zip", checksum: "5a6486ec34138210fe481817f0a4a050a426e5d11cf9534e87470b6f6a76947a"),
        .binaryTarget(name: "libcrypto", url: "https://github.com/kewlbear/Python-iOS/releases/download/0.0.20210401053451/libcrypto.xcframework.zip", checksum: "c28a11461f6560b22c3bd2bf7cd63987217ebdbceffa51a8664dec951559736f"),
        .binaryTarget(name: "libffi", url: "https://github.com/kewlbear/Python-iOS/releases/download/0.0.20210401053451/libffi.xcframework.zip", checksum: "f5ccfbb717bd4297a6fa226a44cf2afebce2ce5241a90ce618b773827da2d737"),
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
