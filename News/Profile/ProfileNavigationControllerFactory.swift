//
//  ProfileNavigationViewControllerFactory.swift
//  News
//
//  Created by Ian Grünig on 26.04.22.
//

import Foundation
import UIKit

struct ProfileNavigationControllerFactory {
    
    static func makeProfileNavigationViewController() -> UINavigationController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ProfileNavigationController") as! UINavigationController
        return vc
    }
    
}
