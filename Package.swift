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
  targets: [
    .target(name: "TextCore"),
    
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
