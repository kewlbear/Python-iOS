// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Python-iOS",
    platforms: [.iOS(.v9)],
    products: [
        .library(
            name: "Python-iOS",
            targets: ["Python", "SSL", "Crypto", "FFI", "PythonSupport"]),
    ],
    targets: [
        .binaryTarget(name: "Python", url: "https://github.com/kewlbear/Python-iOS/releases/download/0.0.1/libpython3.xcframework.zip", checksum: "245c51a97eda854a7b0c7bd507f24d1dfc2efae38f20aceac91fe0fd99a6eebe"),
        .binaryTarget(name: "SSL", url: "https://github.com/kewlbear/Python-iOS/releases/download/0.0.1/libssl.xcframework.zip", checksum: "1fc7dd3e95d5152812bc8d74450fdc45539e4ac53d4008b21b7f0a81d2fc52a9"),
        .binaryTarget(name: "Crypto", url: "https://github.com/kewlbear/Python-iOS/releases/download/0.0.1/libcrypto.xcframework.zip", checksum: "43948ae2aac97bf80445ad0e38dd943b4f903506802633bd82d8b813da0328bf"),
        .binaryTarget(name: "FFI", url: "https://github.com/kewlbear/Python-iOS/releases/download/0.0.1/libffi.xcframework.zip", checksum: "0b028a1068f5f085ba1861b73928b99d14970438639d2531c3f31afe4d0e0e3c"),
        .target(name: "PythonSupport",
                dependencies: [
                    "Python",
                    "SSL",
                    "Crypto",
                    "FFI",
                ],
                resources: [.copy("lib")],
                linkerSettings: [
                    .linkedLibrary("z"),
                    .linkedLibrary("sqlite3"),
                ]
        ),
        .testTarget(
            name: "PythonTests",
            dependencies: ["PythonSupport"]),
    ]
)
