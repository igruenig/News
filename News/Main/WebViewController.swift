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
    
    private var bookmarkController: BookmarkController<JSONStorage<Bookmark>>!
    
    /// The initial url. This might be different then the currently displayed url.
    private(set) public var startURL: URL?
    
    override func loadView() {
        webView = WebViewFactory.makeWebView(injectScripts: ["restyle"])
        
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        webView.backgroundColor = .white
        
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookmarkController = (UIApplication.shared.delegate as! AppDelegate).bookmarkController
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateWebViewAppearance()
    }
    
    /**
     Loads a url in a web view and keeps a reference to the url. The web view is created for you if it has not been loaded yet.
     - Parameter url: The url loaded in the web view.
     */
    func loadURL(_ url: URL) {
        loadViewIfNeeded()
        webView.load(URLRequest(url: url))
        startURL = url
    }
    
    @objc func bookmarkPressed(_ sender: Any) {
        if let url = webView.url, let title = webView.title {
            if bookmarkController.isBookmarked(url.absoluteString) {
               removeBookmark(url)
            } else {
               saveBookmark(url, title: title)
            }
            updateNavigationBar()
        }
    }
    
    @objc func homePressed(_ sender: Any) {
        if startURL != nil {
            loadURL(startURL!)
        }
    }
    
    @objc func readingListPressed(_ sender: Any) {
        // TODO: Show reading list instead of bookmarks
        let vc = ViewControllerFactory.makeViewController(identifier: "BookmarksNavigationController") as! UINavigationController
        navigationController?.present(vc, animated: true)
    }
    
    private func removeBookmark(_ url: URL) {
        if bookmarkController.remove(url.absoluteString){
            // TODO: Show visual confirmation to user
            print("bookmark removed")
        } else {
            // TODO: Show error to user
            print("error removing bookmark")
        }
    }
    
    private func saveBookmark(_ url: URL, title: String) {
        if bookmarkController.add(url, title: title) {
            // TODO: Show visual confirmation to user
            print("bookmark added")
        } else {
            // TODO: Show error to user
            print("error adding bookmark")
        }
    }
    
    private func updateWebViewAppearance() {
        if traitCollection.userInterfaceStyle == .dark {
            webView.evaluateJavaScript(WebViewFactory.loadScriptString(scriptName: "enableDarkMode")!)
        } else {
            webView.evaluateJavaScript(WebViewFactory.loadScriptString(scriptName: "disableDarkMode")!)
        }
    }
    
    private func updateNavigationBar() {
        if let url = webView.url, url.pathComponents.count > 2, url.pathComponents[2] != "tags" {
            // home button
            let tagHomeButton = UIBarButtonItem(image: UIImage(systemName: "house"), style: .plain, target: self, action: #selector(homePressed(_:)))
            tagHomeButton.tintColor = .label
            
            // bookmark button
            var systemName = "bookmark"
            if bookmarkController.isBookmarked(url.absoluteString) {
                systemName = "bookmark.fill"
            }
            
            let bookmarkButton = UIBarButtonItem(image: UIImage(systemName: systemName), style: .plain, target: self, action: #selector(bookmarkPressed(_:)))
            bookmarkButton.tintColor = .label
            
            parent?.navigationItem.leftBarButtonItems = [tagHomeButton, bookmarkButton]
        } else {
            let readingListButton = UIBarButtonItem(image: UIImage(systemName: "eyeglasses"), style: .plain, target: self, action: #selector(readingListPressed(_:)))
            readingListButton.tintColor = .label
            
            parent?.navigationItem.leftBarButtonItems = [readingListButton]
        }
    }
}

extension WebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        updateWebViewAppearance()
        updateNavigationBar()
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
