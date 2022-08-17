//
//  WebUnitSwiftUI.swift
//  TaboolaSwiftUI
//
//  Copyright © 2022 Taboola. All rights reserved.
//

import SwiftUI
import WebKit
import TaboolaSDK

public struct WebUnitSwiftUI: UIViewRepresentable {
    
    private let source: String
    private let baseURL: URL
    private let pageWrapper: WebPageWrappable
    
    public init(pageWrapper: WebPageWrappable, source: String, baseURL: URL) {
        self.pageWrapper = pageWrapper
        self.source = source
        self.baseURL = baseURL
    }
    
    public func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        config.preferences.javaScriptCanOpenWindowsAutomatically = true
        
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.isOpaque = false
        webView.backgroundColor = .clear
        
        pageWrapper.page.createUnit(with: webView)
        
        try? loadPage(in: webView)
        return webView
    }
    
    public func updateUIView(_ uiView: WKWebView, context: Context) {
        // update view if needed
    }
    
    private func loadPage(in webView: WKWebView) throws {
        guard let htmlPath = Bundle.main.path(forResource: source, ofType: "html") else {
            assertionFailure("html path should exist!!!")
            return
        }
        
        let appHtml = try String(contentsOfFile: htmlPath, encoding: .utf8)
        webView.loadHTMLString(appHtml, baseURL: baseURL)
    }
}
