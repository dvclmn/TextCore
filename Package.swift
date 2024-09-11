// swift-tools-version:5.6

import PackageDescription

let localPackagesRoot = "/Users/dvclmn/Apps/_ Swift Packages"

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
    .package(name: "Helpers", path: "\(localPackagesRoot)/SwiftCollection/Helpers"),
    .package(name: "Styles", path: "\(localPackagesRoot)/Styles"),
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


for target in package.targets {
  target.swiftSettings = target.swiftSettings ?? []
  target.swiftSettings?.append(
    .unsafeFlags([
      "-Xfrontend", "-warn-concurrency",
      "-Xfrontend", "-enable-actor-data-race-checks",
      "-enable-bare-slash-regex",
    ])
  )
}
