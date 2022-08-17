//
//  ClassicUnitSwiftUI.swift
//  TaboolaSwiftUI
//
//  Copyright © 2022 Taboola. All rights reserved.
//

import SwiftUI
import TaboolaSDK

public protocol ClassicUnitProvidable {
    var unit: ClassicUnitSwiftUI { get }
}

public struct ClassicUnitSwiftUI: UIViewRepresentable {
    
    private let mode: String
    private let pageWrapper: СlassicPageWrappable
    
    @Binding var height: CGFloat
    public let placement: String
        
    public init(pageWrapper: СlassicPageWrappable, placement: String, mode: String, height: Binding<CGFloat>) {
        self.pageWrapper = pageWrapper
        self.placement = placement
        self.mode = mode
        self._height = height
    }
    
    public func makeUIView(context: Context) -> TBLClassicUnit {
        pageWrapper.delegates.append(context.coordinator)

        if let dequeuedUnit = pageWrapper.reusableViewsQueue.dequeue(for: placement) {
            return dequeuedUnit
        }
        
        let classicUnit = pageWrapper.page.createUnit(withPlacementName: placement, mode: mode)
        pageWrapper.reusableViewsQueue.register(classicUnit, for: placement)

        classicUnit.fetchContent()
        
        return classicUnit
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    public func updateUIView(_ uiView: TBLClassicUnit, context: Context) {
        // update view if needed
    }
}

public class Coordinator: NSObject, ClassicPageWrapperDelegate, ClassicUnitProvidable {
    
    public var unit: ClassicUnitSwiftUI
 
    init(_ unit: ClassicUnitSwiftUI) {
        self.unit = unit
    }
    
    public func didLoadWithHeight(height: CGFloat) {
        unit.height = height
    }
}
