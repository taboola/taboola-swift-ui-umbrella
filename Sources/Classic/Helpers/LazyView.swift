//
//  LazyView.swift
//  TaboolaSwiftUI
//
//  Copyright © 2022 Taboola. All rights reserved.
//

import SwiftUI

public struct LazyView<Content: View>: View {
    
    let build: () -> Content
    
    public init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    
    public var body: Content {
        build()
    }
}
