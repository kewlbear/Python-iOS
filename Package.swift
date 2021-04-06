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
        .binaryTarget(name: "libpython3", url: "https://github.com/kewlbear/Python-iOS/releases/download/0.0.20210406082436/libpython3.xcframework.zip", checksum: "8eb9cca37b6c5c7f4d4ddf39f6455bb64b1886d69d05df2439cab5f24489a207"),
        .binaryTarget(name: "libssl", url: "https://github.com/kewlbear/Python-iOS/releases/download/0.0.20210406082436/libssl.xcframework.zip", checksum: "b1faca58285140fecbee4b1728ee947c72a48cd5c9dd6a90618734676c9107d0"),
        .binaryTarget(name: "libcrypto", url: "https://github.com/kewlbear/Python-iOS/releases/download/0.0.20210406082436/libcrypto.xcframework.zip", checksum: "436fbaf6f69bf7e74a87daf0418fb807409d5ef7abaa816575bb61392a0efd78"),
        .binaryTarget(name: "libffi", url: "https://github.com/kewlbear/Python-iOS/releases/download/0.0.20210406082436/libffi.xcframework.zip", checksum: "6f38a48e3c1a92b4eb09b43ba8a96d475f1d6a0925872ada489a8d8f5175baa7"),
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
