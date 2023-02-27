import Foundation

/// Specify navigation functions from this controller to others
/// Connection data controller -> coordinator
/// # Example #
/// ```
/// func displayLicense(initialData: LicenseInitialData)
/// ```
/// Warning: Don't forget to add **DetailMeteoriteCoordinatorDelegate** as an extension to a designated coordinator
protocol DetailMeteoriteCoordinatorDelegate: CoordinatorDelegate {

}

/// Connection view -> data controller
protocol DetailMeteoriteViewDataControllerDelegate: DataControllerType {
    func didTapBack()
}

/// Connection view model -> data controller
protocol DetailMeteoriteViewModelDataControllerDelegate: ViewModelType {
    
}

/// Connection model -> data controller
protocol DetailMeteoriteModelDataControllerDelegate: AnyObject {

}

final class DetailMeteoriteDataController {
    
    private let model: DetailMeteoriteDataModelControllerDelegate
    private let coordinator: DetailMeteoriteCoordinatorDelegate
    private weak var view: DetailMeteoriteViewType?
    

    init(coordinator: DetailMeteoriteCoordinatorDelegate, view: DetailMeteoriteViewType, model: DetailMeteoriteDataModelControllerDelegate) {
        self.coordinator = coordinator
        self.view = view
        self.model = model
    }
    
    func viewDidLoad() {
        presentViewModel()
    }
    
    private func presentViewModel() {
        DispatchQueue.main.async { [self] in
            let viewModel = DetailMeteoriteViewModel(delegate: self, metorite: model.initialData.meteorite)
            view?.display(viewModel)
        }
    }
}

extension DetailMeteoriteDataController: DetailMeteoriteViewDataControllerDelegate {
    func didTapBack() {
        coordinator.back()
    }
    
    
    
}

extension DetailMeteoriteDataController: DetailMeteoriteViewModelDataControllerDelegate {
    
}

extension DetailMeteoriteDataController: DetailMeteoriteModelDataControllerDelegate {
    
    
}
