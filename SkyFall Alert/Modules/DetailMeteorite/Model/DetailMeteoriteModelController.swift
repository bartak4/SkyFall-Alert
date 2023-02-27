import Foundation

/// Connection data controller -> model controller
protocol DetailMeteoriteDataModelControllerDelegate: AnyObject {
    var initialData: DetailMeteoriteInitialData { get }
}

final class DetailMeteoriteModelController {

    weak var delegate: DetailMeteoriteModelDataControllerDelegate?
    
    var initialData: DetailMeteoriteInitialData

    required init(initialData: DetailMeteoriteInitialData) {
        self.initialData = initialData
    }
}

extension DetailMeteoriteModelController: DetailMeteoriteDataModelControllerDelegate {

}
