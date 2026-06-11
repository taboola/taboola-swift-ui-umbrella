// swift-tools-version:5.3
import PackageDescription
let package = Package(
    name: "TaboolaSDK-SwiftUI-Umbrella",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "TaboolaSDK-SwiftUI-Umbrella",
            targets: ["TaboolaSDK-SwiftUI-Umbrella"]
        )
    ],
    targets: [
        .target(
            name: "TaboolaSDK-SwiftUI-Umbrella",
            dependencies: ["TaboolaSDK"],
            path: "Sources"
        ),
        .binaryTarget(
            name: "TaboolaSDK",
            url: "https://artifactory-build.taboolasyndication.com/artifactory/ios-releases/4.1.14/ipa/TaboolaSDK.xcframework.zip",
            checksum: "ed14867f25fae4f8aaec00dd7125456bfc3e0f357d77a58d368543ca4c0b3ec9")
    ]
)
