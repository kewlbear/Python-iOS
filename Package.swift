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
        .binaryTarget(name: "libpython3", url: "https://github.com/kewlbear/Python-iOS/releases/download/0.0.20210406053138/libpython3.xcframework.zip", checksum: "ba5e80532293edb265ca53084c901fa5ef6617691aff8557399f024c63dc3570"),
        .binaryTarget(name: "libssl", url: "https://github.com/kewlbear/Python-iOS/releases/download/0.0.20210406053138/libssl.xcframework.zip", checksum: "6497b573c4cd24d5f16a7d3e3a21f1ee90f70d5bea4d41235a16f6ac3578f564"),
        .binaryTarget(name: "libcrypto", url: "https://github.com/kewlbear/Python-iOS/releases/download/0.0.20210406053138/libcrypto.xcframework.zip", checksum: "a92cd467040937f94753d7635613af67132e420e11b38d1d508342ac91c9f7ae"),
        .binaryTarget(name: "libffi", url: "https://github.com/kewlbear/Python-iOS/releases/download/0.0.20210406053138/libffi.xcframework.zip", checksum: "4174e0abe87e787f2e6223937adebdb9a3c0e6c34eda09ad6772af540c68869f"),
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
