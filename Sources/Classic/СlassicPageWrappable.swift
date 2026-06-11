//
//  СlassicPageWrappable.swift
//  TaboolaSwiftUI
//
//  Copyright © 2022 Taboola. All rights reserved.
//

import Foundation
import TaboolaSDK

public protocol СlassicPageWrappable: AnyObject {
    var page: TBLClassicPage! { get }
    var delegates: [UnitCoordinator] { get set }
    var reusableViewsQueue: ReusableViewsQueue<String, TBLClassicUnit> { get }
}
