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
            url: "https://taboola-mobile-sdk.s3-us-west-2.amazonaws.com/ios/sdk-binaries/xcframework/official/3.8.41/TaboolaSDK.xcframework.zip",
            checksum: "b5f5646fc026f346fd3cd927d9520bb1df7d94c446906fbe48b45036df5cc0e0")
    ]
)
