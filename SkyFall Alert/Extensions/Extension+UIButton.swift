//
//  Extension+UIButton.swift
//  SkyFall Alert
//
//  Created by Bartak, Marek on 27.02.23.
//

import Foundation
import UIKit

extension UIButton {
    func setDefaultButtonStyle() {
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .capsule
        configuration.baseBackgroundColor = .gray.withAlphaComponent(0.7)
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        self.configuration = configuration
        self.setTitleColor(.white, for: .normal)
    }
}
