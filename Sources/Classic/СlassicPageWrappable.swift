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
    var delegates: [Coordinator] { get set }
    var reusableViewsQueue: ReusableViewsQueue<String, TBLClassicUnit> { get }
}
