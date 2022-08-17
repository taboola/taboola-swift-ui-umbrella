//
//  WebPageWrappable.swift
//  TaboolaSwiftUI
//
//  Copyright © 2022 Taboola. All rights reserved.
//

import TaboolaSDK

public protocol WebPageWrappable: AnyObject {
    var page: TBLWebPage! { get }
}
