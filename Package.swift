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
        .binaryTarget(name: "libpython3", url: "https://github.com/kewlbear/Python-iOS/releases/download/0.0.20210406061106/libpython3.xcframework.zip", checksum: "libpython3.xcframework_CHECKSUM"),
        .binaryTarget(name: "libssl", url: "https://github.com/kewlbear/Python-iOS/releases/download/0.0.20210406061106/libssl.xcframework.zip", checksum: "b58e79334d46bef5f3188be62a46008023fad01fa28eb71848a42e37540db1c0"),
        .binaryTarget(name: "libcrypto", url: "https://github.com/kewlbear/Python-iOS/releases/download/0.0.20210406061106/libcrypto.xcframework.zip", checksum: "fb7c83c71010f202f00bccac4ebf69df9948b1c434095cdd2d97124dec0f18aa"),
        .binaryTarget(name: "libffi", url: "https://github.com/kewlbear/Python-iOS/releases/download/0.0.20210406061106/libffi.xcframework.zip", checksum: "947d0b15019a5c536fbc97795a0d09a0cb0381a2998d8ac5e717429ecf9c0ce8"),
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
