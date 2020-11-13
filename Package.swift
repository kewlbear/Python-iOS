// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Python-iOS",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Python-iOS",
            targets: ["CPython", "PythonKit", "Resources"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(name: "PythonKit", dependencies: [
                    "CPython", "BZip2", "OpenSSL", "XZ"]),
        .binaryTarget(name: "CPython", path: "Frameworks/CPython.xcframework"),
        .binaryTarget(name: "BZip2", path: "Frameworks/BZip2.xcframework"),
        .binaryTarget(name: "OpenSSL", path: "Frameworks/OpenSSL.xcframework"),
        .binaryTarget(name: "XZ", path: "Frameworks/XZ.xcframework"),
        .target(name: "Resources", resources: [.copy("lib")]),
//        .testTarget(
//            name: "PythonTests",
//            dependencies: ["PythonKit",
//                           .product(name: "Csqlite3", package: "Csqlite3")]),
    ]
)
