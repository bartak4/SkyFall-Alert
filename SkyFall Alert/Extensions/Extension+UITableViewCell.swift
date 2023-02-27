//
//  Extension+UITableViewCell.swift
//  SkyFall Alert
//
//  Created by Bartak, Marek on 25.02.23.
//

import Foundation
import UIKit

public extension UITableViewCell {
    
    static var className: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
    
    static var reuseIdentifier: String {
        return self.className
    }
    
}
