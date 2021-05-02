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

struct PostWebView: UIViewControllerRepresentable {
    
    var postUrl: String
    
    func makeUIViewController(context: Context) -> WebviewController {
        guard let url = URL(string: postUrl) else { return WebviewController() }

        let webviewController = WebviewController()
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        webviewController.webview.load(request)
        
        return webviewController
    }
    
    func updateUIViewController(_ webviewController: WebviewController, context: Context) {
                
    }
}
