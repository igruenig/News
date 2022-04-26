//
//  WebViewControllerFactory.swift
//  News
//
//  Created by Ian Grünig on 26.04.22.
//

import Foundation
import UIKit

struct WebViewControllerFactory {
    
    static func makeWebViewControllers() -> [WebViewController] {
        return WebRoutes.tags.map({ tag in
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "WebViewController") as! WebViewController
            
            if let url = WebRoutes.urlForTag(tag) {
                vc.title = tag
                vc.loadURL(url)
            }
            
            return vc
        })
    }
    
}
