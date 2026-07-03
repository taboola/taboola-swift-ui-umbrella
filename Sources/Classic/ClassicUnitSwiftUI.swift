//
//  ClassicUnitSwiftUI.swift
//  TaboolaSwiftUI
//
//  Copyright © 2022 Taboola. All rights reserved.
//

import SwiftUI
import TaboolaSDK

public struct ClassicUnitSwiftUI: UIViewRepresentable, UnitProvidable {

    private let pageWrapper: СlassicPageWrappable
    private let mode: String
    private let extraProperties: [String: String]?

    /// Placement name configured for this unit in the Taboola dashboard. Used
    /// by the page wrapper to route SDK height callbacks back to this unit.
    public let placement: String

    /// Laid-out height reported by the SDK after content loads. Bind to a
    /// `@State` on the parent SwiftUI view and apply with `.frame(height:)`.
    @Binding public var height: CGFloat

    /// Creates a SwiftUI Taboola Classic unit.
    ///
    /// - Parameters:
    ///   - pageWrapper: The page wrapper that owns the underlying
    ///     `TBLClassicPage`. Must outlive every unit created against it.
    ///   - placement: Placement name configured for the publisher in the
    ///     Taboola dashboard.
    ///   - mode: Mode identifier configured for the publisher (e.g.
    ///     `"thumbs-feed-01"`).
    ///   - height: Binding the unit writes into once the SDK reports the
    ///     laid-out height.
    ///   - extraProperties: Optional key/value pairs forwarded to the
    ///     underlying `TBLClassicUnit.extraProperties`.
    public init(pageWrapper: СlassicPageWrappable,
                placement: String,
                mode: String,
                height: Binding<CGFloat>,
                extraProperties: [String: String]? = nil) {
        self.pageWrapper = pageWrapper
        self.placement = placement
        self.mode = mode
        self._height = height
        self.extraProperties = extraProperties
    }

    public func makeUIView(context: Context) -> TBLClassicUnit {
        if let dequeuedUnit = pageWrapper.reusableViewsQueue.dequeue(for: placement) {
            pageWrapper.delegates.append(context.coordinator)
            return dequeuedUnit
        }

        let classicUnit = pageWrapper.page.createUnit(withPlacementName: placement, mode: mode)
        pageWrapper.reusableViewsQueue.register(classicUnit, for: placement)
        pageWrapper.delegates.append(context.coordinator)
        if let extraProperties {
            classicUnit.extraProperties = extraProperties
        }
        classicUnit.fetchContent()
        return classicUnit
    }

    public func updateUIView(_ uiView: TBLClassicUnit, context: Context) {
        // update view if needed
    }

    public func makeCoordinator() -> Coordinator {
        ClassicUnitCoordinator(self)
    }
}

/// SwiftUI coordinator for ``ClassicUnitSwiftUI``.
///
/// Receives SDK callbacks routed through the page wrapper and propagates the
/// reported height into the unit's `@Binding`. Created automatically by
/// `makeCoordinator()`; publishers do not construct it directly.
public class ClassicUnitCoordinator: Coordinator, ClassicPageWrapperDelegate {
    // No height override needed — base `didLoadWithHeight` does the right thing
    // for any resizable unit. Subclass exists only to provide a typed init.
    public init(_ unit: ClassicUnitSwiftUI) {
        super.init(unit: unit)
    }
}
