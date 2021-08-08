//
//  WKWebView+Preview.swift
//  iOSPressDemo
//
//  Created by Kazi Miftahul Hoque on 12/7/21.
//

import Foundation
import SwiftUI

struct BrowserPreview: PreviewProvider {
    static var previews: some View {
        Group {
            previewWithNavigationController(Browser())
        }
    }
}

struct BrowserResourcePreview: PreviewProvider {
    static var previews: some View {
        Group{
            UIViewPreview {
                let img = UIImage(systemName: "arrow.left")!.withTintColor(.blue, renderingMode: .alwaysTemplate)
                return UIImageView(image: img)
            }
            UIViewControllerPreview {
                let n = UINavigationController()
                let v = UIViewController()
                let img = UIImage(systemName: "arrow.left")!.withTintColor(.blue, renderingMode: .alwaysTemplate)
                v.navigationItem.setLeftBarButton(UIBarButtonItem(image: img, style: .plain, target: v, action: #selector(UIViewController.viewDidLoad)), animated: true)
                n.pushViewController(v, animated: true)
                return n
            }
        }
    }
}
