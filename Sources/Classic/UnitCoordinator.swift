//
//  UnitCoordinator.swift
//  TaboolaSwiftUI
//
//  Copyright © 2026 Taboola. All rights reserved.
//

import Foundation

/// Common shape every SwiftUI unit struct exposes so the page wrapper can
/// route SDK callbacks generically (filter delegates by placement, propagate
/// height into the unit's `@Binding`). Adopting this is what lets a new unit
/// type plug into `UnitCoordinator` without page-wrapper changes.
public protocol UnitProvidable {
    var placement: String { get }
    var height: CGFloat { get set }
}

/// Abstract parent coordinator for all unit types.
///
/// Holds the unit as `any UnitProvidable` (rather than a typed property on each
/// subclass) so shared behavior — height propagation, placement lookup — lives
/// in one place. Subclasses override only when their unit needs different
/// behavior (e.g. a fixed-size banner would override `didLoadWithHeight` to a no-op).
public class UnitCoordinator: NSObject {
    public var unit: any UnitProvidable

    public init(unit: any UnitProvidable) {
        self.unit = unit
        super.init()
    }

    /// Default height propagation: write through the unit's `@Binding height`
    /// so SwiftUI re-lays out. The Binding's setter routes the update to the
    /// original source even though `unit` is a struct copy in the existential.
    public func didLoadWithHeight(height: CGFloat) {
        if unit.height == height { return }
        unit.height = height
    }
}
