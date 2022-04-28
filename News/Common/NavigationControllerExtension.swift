//
//  NavigationControllerExtension.swift
//  News
//
//  Created by Ian Grünig on 28.04.22.
//

import Foundation
import UIKit

extension UINavigationController {
    
    @objc func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
