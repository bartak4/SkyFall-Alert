//
//  DataControllerType.swift
//  SkyFall Alert
//
//  Created by Bartak, Marek on 25.02.23.
//

import Foundation

public protocol DataControllerType: ViewModelType {
    /// View is initialized from storyboard and ready to display a view model and to interact
    func viewDidLoad()
}
