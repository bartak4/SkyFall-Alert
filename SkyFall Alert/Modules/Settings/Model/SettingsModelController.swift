import Foundation

/// Connection data controller -> model controller
protocol SettingsDataModelControllerDelegate: AnyObject {
    var initialData: SettingsInitialData { get }
}

final class SettingsModelController {

    weak var delegate: SettingsModelDataControllerDelegate?
    
    var initialData: SettingsInitialData

    required init(initialData: SettingsInitialData) {
        self.initialData = initialData
    }
}

extension SettingsModelController: SettingsDataModelControllerDelegate {

}
