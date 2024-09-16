// swift-tools-version:5.6

import PackageDescription

let localPackagesRoot = "/Users/dvclmn/Apps/_ Swift Packages"

let package = Package(
  name: "TextCore",
  platforms: [
    .iOS("16.0"),
    .macOS("12.0")
  ],
  products: [
    .library(
      name: "TextCore",
      targets: ["TextCore"]
    )
  ],
  dependencies: [
    .package(url: "https://github.com/mattmassicotte/nsui", from: "1.3.0")
  ],
  targets: [
    .target(name: "TextCore", dependencies: [.product(name: "NSUI", package: "nsui")]),
    
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
