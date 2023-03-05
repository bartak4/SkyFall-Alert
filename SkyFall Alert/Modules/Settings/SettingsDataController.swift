import Foundation

/// Specify navigation functions from this controller to others
/// Connection data controller -> coordinator
/// # Example #
/// ```
/// func displayLicense(initialData: LicenseInitialData)
/// ```
/// Warning: Don't forget to add **SettingsCoordinatorDelegate** as an extension to a designated coordinator
protocol SettingsCoordinatorDelegate: CoordinatorDelegate {

}

/// Connection view -> data controller
protocol SettingsViewDataControllerDelegate: DataControllerType {
    func didTapConfirm(massValue: Float, yearsValue: Float)
}

/// Connection view model -> data controller
protocol SettingsViewModelDataControllerDelegate: AnyObject {
    
}

/// Connection model -> data controller
protocol SettingsModelDataControllerDelegate: AnyObject {

}

final class SettingsDataController {
    
    private let model: SettingsDataModelControllerDelegate
    private let coordinator: SettingsCoordinatorDelegate
    private weak var view: SettingsViewType?

    init(coordinator: SettingsCoordinatorDelegate, view: SettingsViewType, model: SettingsDataModelControllerDelegate) {
        self.coordinator = coordinator
        self.view = view
        self.model = model
    }
    
    func viewDidLoad() {
        presentViewModel()
    }
    
    private func presentViewModel() {
        DispatchQueue.main.async { [self] in
            let viewModel = SettingsViewModel(delegate: self, meteorites: model.initialData.meteorites, currentFilter: model.initialData.currentFilter)
            view?.display(viewModel)
        }
    }
}

extension SettingsDataController: SettingsViewDataControllerDelegate {
    func didTapConfirm(massValue: Float, yearsValue: Float) {
        model.initialData.filterDelegate.filtersSelected(filter: .init(minMass: massValue, minYear: yearsValue))
        coordinator.dismiss()
    }
}

extension SettingsDataController: SettingsViewModelDataControllerDelegate {
    
}

extension SettingsDataController: SettingsModelDataControllerDelegate {
    
}
