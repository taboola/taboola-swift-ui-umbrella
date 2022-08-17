//
//  NativeUnitSwiftUI.swift
//  TaboolaSwiftUI
//
//  Copyright © 2022 Taboola. All rights reserved.
//

import SwiftUI
import TaboolaSDK

public protocol NativeViewable: UIView {
    var titleLabel: TBLTitleLabel { get }
    var imageView: TBLImageView { get }
    var brandingLabel: TBLBrandingLabel { get }
    
    func updateLayout(targetWidth: CGFloat)
}

public struct NativeUnitSwiftUI<View: NativeViewable>: UIViewRepresentable {
    
    private let item: TBLNativeItem
    private let width: CGFloat
        
    /// Initializer for SwiftUI native unit.
    /// - Parameters:
    ///   - item: a native item reference to fill data in the unit.
    ///   - width: a target width for current unit.
    public init(_ item: TBLNativeItem, targetWidth width: CGFloat) {
        self.item = item
        self.width = width
    }
    
    public func makeUIView(context: Context) -> View {
        let view = View()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentHuggingPriority(.required, for: .horizontal)
        
        item.initTitleView(view.titleLabel)
        item.initThumbnailView(view.imageView)
        item.initBrandingView(view.brandingLabel)
        
        return view
    }
    
    public func updateUIView(_ uiView: View, context: Context) {
        uiView.updateLayout(targetWidth: width)
    }
}
