//
//  AlertViewPresentable.swift
//  SkyFall Alert
//
//  Created by Bartak, Marek on 27.02.23.
//

import Foundation
import UIKit

protocol AlertViewPresentable: UIViewController {
    func display(alert: AlertViewModel)
}

struct AlertViewModel {
    let title: String
    let message: String
    let style: UIAlertController.Style
}

extension AlertViewPresentable {
    
    func display(alert: AlertViewModel) {
        let alertController = UIAlertController(title: alert.title, message: alert.message, preferredStyle: alert.style)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
}


