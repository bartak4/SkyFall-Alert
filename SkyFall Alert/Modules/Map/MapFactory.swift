import Foundation
import UIKit

extension MapViewController {
    
    /// Acessible only from a coordinator!
    /// - Parameters:
    ///   - initialData: Data needed to reference from another view controller
    ///   - coordinator: Current coordinator reference, don't forget to add **MapCoordinatorDelegate** as an extension to a designated coordinator
    /// - Warning: Requires a storyboard with name 'Map.storyboard' containing a single view controller with storyboard ID 'MapViewController'
    /// - Returns: Initialized view controller from storyboard
    static func instantiate(initialData: MapInitialData, coordinator: MapCoordinatorDelegate) -> MapViewType {
        let viewController = MapViewController()
        let modelController = MapModelController(initialData: initialData)
        let dataController = MapDataController(coordinator: coordinator, view: viewController, model: modelController)
        viewController.dataController = dataController
        modelController.delegate = dataController
        return viewController
    }
}
