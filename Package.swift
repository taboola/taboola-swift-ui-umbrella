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
            url: "https://taboola-mobile-sdk.s3-us-west-2.amazonaws.com/ios/sdk-binaries/xcframework/official/4.0.10/TaboolaSDK.xcframework.zip",
            checksum: "f2304e09543237f6208662926de415e5a48ffcbef81259a24474628e42397440")
    ]
)
