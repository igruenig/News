//
//  WebViewController.swift
//  News
//
//  Created by Ian Grünig on 26.04.22.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    var webView: WKWebView!
    var currentURL: URL?
    
    override func loadView() {
        webView = WebViewFactory.makeWebView(injectScripts: ["restyle"])
        
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        webView.backgroundColor = .white
        
        view = webView
    }
    
    func loadURL(_ url: URL) {
        loadViewIfNeeded()
        webView.load(URLRequest(url: url))
        currentURL = url
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateWebViewAppearance()
    }
    
    private func updateWebViewAppearance() {
        if traitCollection.userInterfaceStyle == .dark {
            webView.evaluateJavaScript(WebViewFactory.loadScriptString(scriptName: "enableDarkMode")!)
        } else {
            webView.evaluateJavaScript(WebViewFactory.loadScriptString(scriptName: "disableDarkMode")!)
        }
    }
}

extension WebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        updateWebViewAppearance()
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.navigationType == .linkActivated {
            
            // open external links with safari
            if let url = navigationAction.request.url, let host = url.host, !host.hasPrefix("mb21.github.io") {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                    decisionHandler(.cancel)
                    return
                }
            }
            
        }
        
        decisionHandler(.allow)
    }
    
}

extension WebViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}
