//
//  ReusableViewsQueue.swift
//  TaboolaSwiftUI
//
//  Copyright © 2022 Taboola. All rights reserved.
//

import UIKit

public protocol ReusableViewsQueueProtocol {
    
    associatedtype Key: Hashable
    associatedtype View: UIView
        
    func dequeue(for key: Key) -> View?
    func register(_ new: View, for key: Key)
}

public final class ReusableViewsQueue<Key: Hashable, View: UIView>: ReusableViewsQueueProtocol {
    
    public init() { }
    
    private var views: [Key: View] = [:]
    
    public func dequeue(for key: Key) -> View? {
        views[key]
    }
    
    public func register(_ new: View, for key: Key) {
        views[key] = new
    }
}
