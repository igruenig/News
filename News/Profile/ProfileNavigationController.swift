//
//  ProfileNavigationController.swift
//  News
//
//  Created by Ian Grünig on 26.04.22.
//

import UIKit

class ProfileNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func closeMenu(_ sender: Any) {
        dismiss(animated: true)
    }

}
