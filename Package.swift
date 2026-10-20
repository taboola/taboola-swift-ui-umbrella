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
            url: "https://taboola-mobile-sdk.s3-us-west-2.amazonaws.com/ios/sdk-binaries/xcframework/official/4.2.9/TaboolaSDK.xcframework.zip",
            checksum: "486c00b27307ffa6ce73e24ea490f3f874f8b7f8791958dfb645aeedd46510b7")
    ]
)
