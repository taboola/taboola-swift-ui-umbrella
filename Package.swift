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
            url: "https://taboola-mobile-sdk.s3.us-west-2.amazonaws.com/ios/spm/3.7.0/TaboolaSDK.xcframework.zip",
            checksum: "093796dbf12cfe5f1e4ef0af470d9b59fe276b9ce5fcb6d44f6f6ed5ff104182"
        )
    ]
)
