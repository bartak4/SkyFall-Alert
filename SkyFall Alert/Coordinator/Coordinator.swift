//
//  Coordinator.swift
//  SkyFall Alert
//
//  Created by Bartak, Marek on 25.02.23.
//

import Foundation
import UIKit

public protocol CoordinatorDelegate: AnyObject {
    func back()
    func dismiss()
}

class MainCoordinator {
    
    public weak var navigationController: UINavigationController?

    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
    }
    
    func start() {
        let vc = MapViewController.instantiate(initialData: MapInitialData(), coordinator: self)
        navigationController?.setViewControllers([vc], animated: true)
    }
}

extension MainCoordinator: CoordinatorDelegate {
    func dismiss() {
        navigationController?.dismiss(animated: true)
    }
    
    func back() {
        navigationController?.popViewController(animated: true)
    }
}

extension MainCoordinator: MapCoordinatorDelegate {
    func displayDetailMeteorite(initialData: DetailMeteoriteInitialData) {
        let vc = DetailMeteoriteViewController.instantiate(initialData: initialData, coordinator: self)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func displaySetting(initialData: SettingsInitialData) {
        let vc = SettingsViewController.instantiate(initialData: initialData, coordinator: self)
        vc.sheetPresentationController?.detents = [.medium()]
        navigationController?.modalPresentationStyle = .pageSheet
        navigationController?.present(vc, animated: true)
    }
}


extension MainCoordinator: DetailMeteoriteCoordinatorDelegate { }

extension MainCoordinator: SettingsCoordinatorDelegate { }
