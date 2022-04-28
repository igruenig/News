//
//  LaunchViewController.swift
//  News
//
//  Created by Ian Grünig on 28.04.22.
//

import UIKit

class LaunchViewController: UIViewController {

    weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.frame = CGRect(x: 0, y: 0, width: 280, height: 280)
        view.addSubview(imageView)
        
        self.imageView = imageView
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        imageView.center = view.center
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let navVC = ViewControllerFactory.makeViewController(identifier: "MainNavigationViewController") as! MainNavigationViewController
        
        DispatchQueue.main.asyncAfter(deadline: .now()+1.5, execute: { [weak self] in
            self?.animate(vc: navVC)
        })
    }
    
    private func animate(vc: MainNavigationViewController) {
        UIView.animate(withDuration: 0.8, animations: { [weak self] in
            guard let this = self else {
                return
            }
            let size = this.view.frame.width * 3
            let diffX  = size - this.view.frame.size.width
            let diffY = this.view.frame.size.height - size
            
            this.imageView.frame = CGRect(x: -(diffX/2.0), y: diffY/2.0, width: size, height: size)
            this.imageView.alpha = 0.0
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: { [weak self] in
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            self?.present(vc, animated: true)
        })
    }

}
