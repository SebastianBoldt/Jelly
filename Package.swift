// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "Jelly",
    platforms: [.iOS(.v10)],
    products: [.library(name: "Jelly", targets: ["Jelly"])],
    targets: [.target(name: "Jelly", path: "Jelly")],
    swiftLanguageVersions: [.v5]
)
