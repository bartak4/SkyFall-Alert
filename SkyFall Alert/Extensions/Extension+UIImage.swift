//
//  Extension+UIImage.swift
//  SkyFall Alert
//
//  Created by Bartak, Marek on 25.02.23.
//

import Foundation
import UIKit

extension UIImage {
    func resize(width: CGFloat, height: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), false, UIScreen.main.scale)
        self.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
