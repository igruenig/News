//
//  WebViewControllerFactory.swift
//  News
//
//  Created by Ian Grünig on 26.04.22.
//

import Foundation
import UIKit

struct WebViewControllerFactory {
    
    // TODO: Loading all WebViews at once is not efficient. Preload only 2: one to the left and one to the right. 3 in total.
    static func makeWebViewControllers() -> [WebViewController] {
        return WebRoutes.tags.map({ tag in
            let vc = ViewControllerFactory.makeViewController(identifier: "WebViewController") as! WebViewController
            
            if let url = WebRoutes.urlForTag(tag) {
                vc.title = tag
                vc.loadURL(url)
            }
            
            return vc
        })
    }
    
}
