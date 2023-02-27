//
//  NavigationController.swift
//  SkyFall Alert
//
//  Created by Bartak, Marek on 26.02.23.
//

import Foundation
import UIKit

protocol SkyFallNavigationControllerType: UINavigationController {
    
}

class SkyFallNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
}

extension SkyFallNavigationController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension SkyFallNavigationController: SkyFallNavigationControllerType {
    
}

