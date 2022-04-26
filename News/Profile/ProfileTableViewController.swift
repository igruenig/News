//
//  ProfileTableViewController.swift
//  News
//
//  Created by Ian Grünig on 26.04.22.
//

import UIKit

class ProfileTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: navigationController, action: #selector(ProfileNavigationController.closeMenu(_:)))
    }

}
