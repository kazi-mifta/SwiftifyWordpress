//
//  PostWebView.swift
//  FitPlan
//
//  Created by Mohammad Mainul Islam on 9/9/20.
//  Copyright © 2020 Arcade Studios. All rights reserved.
//

import Foundation
import SwiftUI
import WebKit

struct PostWebView: UIViewRepresentable {
    
    var postUrl: String
    
    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: self.postUrl) else { return WKWebView() }
        
        let request = URLRequest(url: url)
        let wkWebView = WKWebView()
        wkWebView.load(request)
        wkWebView.allowsBackForwardNavigationGestures = true
        return wkWebView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
}
