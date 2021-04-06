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
        .binaryTarget(name: "libpython3", url: "https://github.com/kewlbear/Python-iOS/releases/download/0.0.20210406044229/libpython3.xcframework.zip", checksum: "c577a1ee4e10b4a89fb8781ab81eeca711a3835fae679573cf0605d9eb365af4"),
        .binaryTarget(name: "libssl", url: "https://github.com/kewlbear/Python-iOS/releases/download/0.0.20210406044229/libssl.xcframework.zip", checksum: "01d3eec0f79c1336ac74cb1803ff5f48172b8958f3a84a92aef75e01d53125ab"),
        .binaryTarget(name: "libcrypto", url: "https://github.com/kewlbear/Python-iOS/releases/download/0.0.20210406044229/libcrypto.xcframework.zip", checksum: "6e547d87146b71aed495868e41b8372d5bed295f3d644bbebb82355e62f986b3"),
        .binaryTarget(name: "libffi", url: "https://github.com/kewlbear/Python-iOS/releases/download/0.0.20210406044229/libffi.xcframework.zip", checksum: "58b0e9a02fbb7cdcc4b29734b266b95cf76703a4139a0f2f1752a727816ef08c"),
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
