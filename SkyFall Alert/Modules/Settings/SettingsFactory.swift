import Foundation
import UIKit

extension SettingsViewController {
    
    /// Acessible only from a coordinator!
    /// - Parameters:
    ///   - initialData: Data needed to reference from another view controller
    ///   - coordinator: Current coordinator reference, don't forget to add **SettingsCoordinatorDelegate** as an extension to a designated coordinator
    /// - Warning: Requires a storyboard with name 'Settings.storyboard' containing a single view controller with storyboard ID 'SettingsViewController'
    /// - Returns: Initialized view controller from storyboard
    static func instantiate(initialData: SettingsInitialData, coordinator: SettingsCoordinatorDelegate) -> SettingsViewType {
        let viewController = SettingsViewController()
        let modelController = SettingsModelController(initialData: initialData)
        let dataController = SettingsDataController(coordinator: coordinator, view: viewController, model: modelController)
        viewController.dataController = dataController
        modelController.delegate = dataController
        return viewController
    }
}
