//
//  PageViewController.swift
//  News
//
//  Created by Ian Grünig on 26.04.22.
//

import UIKit

class PageViewController: UIPageViewController {

    private let webRoutes = WebRoutes()
    
    let webViewControllers: [WebViewController] = WebViewControllerFactory.makeWebViewControllers()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    @objc func showProfileMenu(_ sender: Any) {
        let vc = ViewControllerFactory.makeViewController(identifier: "ProfileNavigationController") as! ProfileNavigationController
        navigationController?.present(vc, animated: true)
    }
    
    private func setup() {
        dataSource = self
        delegate = self
        setViewControllers([webViewControllers[0]], direction: .forward, animated: false)
        
        setupNavigationBar()
        webViewControllers[0].setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        title = webViewControllers[0].title
        
        let profileButton = UIBarButtonItem(image: UIImage(systemName: "person"), style: .plain, target: self, action: #selector(showProfileMenu(_:)))
        profileButton.tintColor = .label
        
        navigationItem.rightBarButtonItems = [profileButton]
    }
}

extension PageViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        title = viewControllers?.first?.title
    }
    
}

extension PageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let webViewController = viewController as? WebViewController {
            if let index = webViewControllers.firstIndex(of: webViewController), index < webViewControllers.count - 1 {
                return webViewControllers[index + 1]
            }
        }
        
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let webViewController = viewController as? WebViewController {
            if let index = webViewControllers.firstIndex(of: webViewController), index > 0 {
                return webViewControllers[index - 1]
            }
        }
        
        return nil
    }
    
}
