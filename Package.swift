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
        .binaryTarget(name: "libpython3", url: "https://github.com/kewlbear/Python-iOS/releases/download/v0.1.0-2023.03.11-06.34.34/libpython3.xcframework.zip", checksum: "4633f6d794cc8e4e104e1f0defdafbd24e1cc797e1cacb4b477eb3f578b2b558"),
        .binaryTarget(name: "libssl", url: "https://github.com/kewlbear/Python-iOS/releases/download/v0.1.0-2023.03.11-06.34.34/libssl.xcframework.zip", checksum: "49d770d18457dcd9ef3be14f563ee495626ff933ac9fd55f86b69f52965f58bf"),
        .binaryTarget(name: "libcrypto", url: "https://github.com/kewlbear/Python-iOS/releases/download/v0.1.0-2023.03.11-06.34.34/libcrypto.xcframework.zip", checksum: "c7a44f659553ad6f79a293cb62fb1771271786a6ba732db62b954279e83d1c95"),
        .binaryTarget(name: "libffi", url: "https://github.com/kewlbear/Python-iOS/releases/download/v0.1.0-2023.03.11-06.34.34/libffi.xcframework.zip", checksum: "77a6078d3845ce916e512e4bf70c7c78101834ccf74e4c47b8afd1c3d6345a0b"),
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
