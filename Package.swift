// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "minja-swift",
  platforms: [.macOS(.v14)],
  products: [
    // Products define the executables and libraries a package produces, making them visible to other packages.
    .library(
      name: "Minja",
      targets: ["Minja"]
    ),
    .executable(name: "minja-benchmark", targets: ["Benchmarks"]),
  ],
  dependencies:    [
    .package(url: "https://github.com/google/swift-benchmark", branch: "main"),
    .package(url: "https://github.com/maiqingqiang/Jinja", branch: "main")
  ],
  targets: [
    // Targets are the basic building blocks of a package, defining a module or a test suite.
    // Targets can depend on other targets in this package and products from dependencies.
    .target(
      name: "Cminja",
      exclude: [
        "minja"
      ]
    ),
    .target(
      name: "Minja",
      dependencies: [
        "Cminja"
      ],
      swiftSettings: [
        .interoperabilityMode(.Cxx)
      ]
    ),
    .testTarget(
      name: "MinjaTests",
      dependencies: [
        "Minja"
      ],
      swiftSettings: [
        .interoperabilityMode(.Cxx)
      ]
    ),
    .testTarget(
      name: "CminjaTests",
      dependencies: ["Cminja"],
      swiftSettings: [
        .interoperabilityMode(.Cxx)
      ]
    ),
    .executableTarget(
        name: "Benchmarks",
        dependencies: [
            "Minja",
            .product(name: "Benchmark", package: "swift-benchmark"),
            "Jinja"
        ],
        swiftSettings: [
          .interoperabilityMode(.Cxx)
        ]
    ),
  ],
  cxxLanguageStandard: .gnucxx17
)
