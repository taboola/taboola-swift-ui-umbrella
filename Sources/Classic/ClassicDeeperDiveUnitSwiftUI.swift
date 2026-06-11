//
//  ClassicDeeperDiveUnitSwiftUI.swift
//  TaboolaSwiftUI
//
//  Copyright © 2026 Taboola. All rights reserved.
//

import SwiftUI
import TaboolaSDK

public struct ClassicDeeperDiveUnitSwiftUI: UIViewRepresentable, UnitProvidable {

    /// Fixed placement name the SDK assigns to deeper-dive units. Mirrored
    /// here so the page wrapper can route height updates through the same
    /// placement-based dispatch as regular classic units.
    // Deeper dive units don't accept a placement name on creation — the SDK
    // assigns this fixed name and reports it back in delegate callbacks, so we
    // mirror it here to satisfy `UnitProvidable` and let the page wrapper route
    // height updates the same way it does for classic units.
    public let placement = "Trigger Deeper Dive"

    private let pageWrapper: СlassicPageWrappable & TBLClassicDeeperDiveDelegate
    private let shouldCloseDeeperDiveOnOrganicClick: Bool
    private let extraProperties: [String: String]?
    fileprivate let deeperDiveDidReceiveClick: ((String, Bool) -> Bool)?

    /// Laid-out height reported by the SDK once the deeper-dive content is
    /// ready. Bind to a `@State` on the parent SwiftUI view.
    @Binding public var height: CGFloat

    /// Creates a SwiftUI Taboola Deeper Dive unit.
    ///
    /// - Parameters:
    ///   - pageWrapper: A page wrapper that conforms to both
    ///     ``СlassicPageWrappable`` and `TBLClassicDeeperDiveDelegate`.
    ///   - shouldCloseDeeperDiveOnOrganicClick: When `true`, the deeper-dive
    ///     surface collapses if the user taps organic content inside it.
    ///   - height: Binding the unit writes into once the SDK reports its
    ///     laid-out height.
    ///   - extraProperties: Optional key/value pairs forwarded to the
    ///     underlying `extraProperties` on the unit.
    ///   - deeperDiveDidReceiveClick: Optional click handler. Receives the
    ///     destination URL and a flag indicating whether the click was on
    ///     organic content. Return `false` to take over navigation (the SDK
    ///     will not open the URL); return `true` (or omit the closure) to let
    ///     the SDK handle it.
    public init(pageWrapper: СlassicPageWrappable & TBLClassicDeeperDiveDelegate,
                shouldCloseDeeperDiveOnOrganicClick: Bool,
                height: Binding<CGFloat>,
                extraProperties: [String: String]? = nil,
                deeperDiveDidReceiveClick: ((String, Bool) -> Bool)? = nil) {
        self.pageWrapper = pageWrapper
        self.shouldCloseDeeperDiveOnOrganicClick = shouldCloseDeeperDiveOnOrganicClick
        self._height = height
        self.extraProperties = extraProperties
        self.deeperDiveDidReceiveClick = deeperDiveDidReceiveClick
    }

    public func makeUIView(context: Context) -> TBLClassicDeeperDiveUnit {
        if let dequeuedUnit = pageWrapper.reusableViewsQueue.dequeue(for: placement) as? TBLClassicDeeperDiveUnit {
            context.coordinator.deeperDiveDidReceiveClick = deeperDiveDidReceiveClick
            pageWrapper.delegates.append(context.coordinator)
            return dequeuedUnit
        }
        // Precondition is added because SDK3 doesn't support deeper dive and will return nil so to avoid force unwrap it is done like this.
        guard let deeperDiveUnit = pageWrapper.page.createDeeperDive(with: pageWrapper) else {
            preconditionFailure("Deeper Dive unit is unavailable for current SDK version.")
        }
        pageWrapper.reusableViewsQueue.register(deeperDiveUnit, for: placement)
        deeperDiveUnit.shouldCloseDeeperDiveOnOrganicClick = shouldCloseDeeperDiveOnOrganicClick

        context.coordinator.deeperDiveDidReceiveClick = deeperDiveDidReceiveClick
        pageWrapper.delegates.append(context.coordinator)
        if let extraProperties {
            deeperDiveUnit.extraProperties = extraProperties
        }
        deeperDiveUnit.fetchContent()
        return deeperDiveUnit
    }

    public func updateUIView(_ uiView: TBLClassicDeeperDiveUnit, context: Context) {
        context.coordinator.deeperDiveDidReceiveClick = deeperDiveDidReceiveClick
    }

    public func makeCoordinator() -> DeeperDiveCoordinator {
        DeeperDiveCoordinator(self)
    }
}

public class DeeperDiveCoordinator: UnitCoordinator, ClassicPageWrapperDelegate {
    // Pulled out of the unit struct at init time so click routing doesn't
    // need to cast `unit` back to the concrete deeper-dive type on every callback.
    public var deeperDiveDidReceiveClick: ((String, Bool) -> Bool)?

    public init(_ unit: ClassicDeeperDiveUnitSwiftUI) {
        self.deeperDiveDidReceiveClick = unit.deeperDiveDidReceiveClick
        super.init(unit: unit)
    }

    /// Invoked by the classic page wrapper from the SDK click delegate. Returning** false**
    /// signals that the publisher will open the article itself (so the SDK won't).
    public func handleDeeperDiveClick(url: String, isOrganic: Bool) -> Bool {
        deeperDiveDidReceiveClick?(url, isOrganic) ?? true
    }
}
