//
//  WebViewFactory.swift
//  News
//
//  Created by Ian Grünig on 26.04.22.
//

import Foundation
import WebKit

struct WebViewFactory {
    
    static func makeWebView(injectScripts scriptNames: [String]) -> WKWebView? {
        let userContentController = WKUserContentController()
        
        for scriptName in scriptNames {
            if let script = loadScript(scriptName: scriptName) {
                userContentController.addUserScript(script)
            }
        }
        
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = userContentController
        
        return WKWebView(frame: UIScreen.main.bounds, configuration: configuration)
    }
    
    static func loadScript(scriptName: String) -> WKUserScript? {
        if let scriptString = loadScriptString(scriptName: scriptName) {
            return WKUserScript(source: scriptString, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        }
        return nil
    }
    
    static func loadScriptString(scriptName: String) -> String? {
        if let filepath = Bundle.main.path(forResource: scriptName, ofType: "js") {
            do {
                return try String(contentsOfFile: filepath)
            } catch {
                return nil
            }
        }
        
        return nil
    }
    
}
