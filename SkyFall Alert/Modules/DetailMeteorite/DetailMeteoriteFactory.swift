import Foundation
import UIKit

extension DetailMeteoriteViewController {
    
    /// Acessible only from a coordinator!
    /// - Parameters:
    ///   - initialData: Data needed to reference from another view controller
    ///   - coordinator: Current coordinator reference, don't forget to add **DetailMeteoriteCoordinatorDelegate** as an extension to a designated coordinator
    /// - Warning: Requires a storyboard with name 'DetailMeteorite.storyboard' containing a single view controller with storyboard ID 'DetailMeteoriteViewController'
    /// - Returns: Initialized view controller from storyboard
    static func instantiate(initialData: DetailMeteoriteInitialData, coordinator: DetailMeteoriteCoordinatorDelegate) -> DetailMeteoriteViewType {
        let viewController = DetailMeteoriteViewController()
        let modelController = DetailMeteoriteModelController(initialData: initialData)
        let dataController = DetailMeteoriteDataController(coordinator: coordinator, view: viewController, model: modelController)
        viewController.dataController = dataController
        modelController.delegate = dataController
        return viewController
    }
}
