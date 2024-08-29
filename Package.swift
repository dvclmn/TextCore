// swift-tools-version:5.6

import PackageDescription

let package = Package(
  name: "TextCore",
  platforms: [
    .iOS("17.0"),
    .macOS("14.0")
  ],
  products: [
    .library(
      name: "TextCore",
      targets: ["TextCore"]
    )
  ],
  dependencies: [
    .package(name: "Helpers", path: "../SwiftCollection/Helpers"),
    .package(name: "Styles", path: "../Styles"),
  ],
  targets: [
    .target(
      name: "TextCore",
      dependencies: ["Helpers", "Styles"]
    ),
    .testTarget(
      name: "TextCoreTests",
      dependencies: ["TextCore"]
    )
  ]
)
