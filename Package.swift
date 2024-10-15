// swift-tools-version:5.10

import PackageDescription

let package = Package(
  name: "TextCore",
  platforms: [
    .iOS("16.0"),
    .macOS("13.0")
  ],
  products: [
    .library(
      name: "TextCore",
      targets: ["TextCore"]
    )
  ],
  dependencies: [
    .package(url: "https://github.com/mattmassicotte/nsui", from: "1.3.0"),
    .package(url: "https://github.com/ChimeHQ/Rearrange.git", from: "1.8.1")
  ],
  targets: [
    .target(name: "TextCore", dependencies: [
      .product(name: "NSUI", package: "nsui"),
      "Rearrange"
    ]),
    
    .testTarget(
      name: "TextCoreTests",
      dependencies: ["TextCore"]
    )
  ]
)



let swiftSettings: [SwiftSetting] = [
  .enableExperimentalFeature("StrictConcurrency"),
  .enableUpcomingFeature("DisableOutwardActorInference"),
  .enableUpcomingFeature("InferSendableFromCaptures")
]

for target in package.targets {
  var settings = target.swiftSettings ?? []
  settings.append(contentsOf: swiftSettings)
  target.swiftSettings = settings
}
