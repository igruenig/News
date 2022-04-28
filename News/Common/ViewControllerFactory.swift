//
//  ViewControllerFactory.swift
//  News
//
//  Created by Ian Grünig on 28.04.22.
//

import Foundation
import UIKit

struct ViewControllerFactory {
    
    static func makeViewController(identifier: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: identifier)
    }
    
}
