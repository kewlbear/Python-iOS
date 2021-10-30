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
        .binaryTarget(name: "libpython3", url: "https://github.com/kewlbear/Python-iOS/releases/download/0.0.20211030092316/libpython3.xcframework.zip", checksum: "b82ae4e1bf02c0cc14d0f7205f44df973167698bfcceba1ac34fbefb0f042e70"),
        .binaryTarget(name: "libssl", url: "https://github.com/kewlbear/Python-iOS/releases/download/0.0.20211030092316/libssl.xcframework.zip", checksum: "2243a27e333c927c2cfdc903af8fbe029cd28e20e3bb38efdf12c6c0585ad63e"),
        .binaryTarget(name: "libcrypto", url: "https://github.com/kewlbear/Python-iOS/releases/download/0.0.20211030092316/libcrypto.xcframework.zip", checksum: "b307061416a1ec903115d84ffe195e7fbd76ca76d7aa0be24eabf2dcfc284fcc"),
        .binaryTarget(name: "libffi", url: "https://github.com/kewlbear/Python-iOS/releases/download/0.0.20211030092316/libffi.xcframework.zip", checksum: "1f1d02c758af22f7f92505358f915b8dcfdbd2f15a44b6f345b4fd1bdd4cef9c"),
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
