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
        .binaryTarget(name: "libpython3", url: "https://github.com/kewlbear/Python-iOS/releases/download/0.0.20210416071604/libpython3.xcframework.zip", checksum: "e04f8175549283c3a5af54e5997db3ab12e6dfecc278dedd04ed85c05c36283a"),
        .binaryTarget(name: "libssl", url: "https://github.com/kewlbear/Python-iOS/releases/download/0.0.20210416071604/libssl.xcframework.zip", checksum: "1e10930fbe511663e829cbf6f76554b44094ed3fcda7d136a9bf9dcf1849f2be"),
        .binaryTarget(name: "libcrypto", url: "https://github.com/kewlbear/Python-iOS/releases/download/0.0.20210416071604/libcrypto.xcframework.zip", checksum: "6837dda1876ad567202a827298774d3dbf21ad044a1d7d2cfcbd6cb2f45c1440"),
        .binaryTarget(name: "libffi", url: "https://github.com/kewlbear/Python-iOS/releases/download/0.0.20210416071604/libffi.xcframework.zip", checksum: "d5af8d9f5824f6f08235a55f03b2d7d03e2992e2f5391137c897fbbd1889960d"),
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
