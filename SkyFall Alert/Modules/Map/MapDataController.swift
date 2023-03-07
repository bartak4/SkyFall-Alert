import Foundation

/// Specify navigation functions from this controller to others
/// Connection data controller -> coordinator
/// # Example #
/// ```
/// func displayLicense(initialData: LicenseInitialData)
/// ```
/// Warning: Don't forget to add **MapCoordinatorDelegate** as an extension to a designated coordinator
protocol MapCoordinatorDelegate: CoordinatorDelegate {
    func displayDetailMeteorite(initialData: DetailMeteoriteInitialData)
    func displaySetting(initialData: SettingsInitialData)
}

/// Connection view -> data controller
protocol MapViewDataControllerDelegate: DataControllerType {
    func didTapMainButton()
    func didTapSettings()
    func meteorSelected(meteor: Meteorite)
}

/// Connection view model -> data controller
protocol MapViewModelDataControllerDelegate: AnyObject {
    
}

/// Connection model -> data controller
protocol MapModelDataControllerDelegate: AnyObject {
    func presentError(_ error: Error)
    func updateMeteors(meteors: [Meteorite])
}

final class MapDataController {
    
    private let model: MapDataModelControllerDelegate
    private let coordinator: MapCoordinatorDelegate
    private weak var view: MapViewType?
    
    private var meteorites: [Meteorite] = []
    private var currentFilter: Filter?

    init(coordinator: MapCoordinatorDelegate, view: MapViewType, model: MapDataModelControllerDelegate) {
        self.coordinator = coordinator
        self.view = view
        self.model = model
    }
    
    func viewDidLoad() {
        presentViewModel()
    }
    
    private func presentViewModel() {
        DispatchQueue.main.async { [self] in
            let viewModel = MapViewModel(delegate: self, meteorites: getMeteorites(), isFilterActive: getIsFilterActive())
            view?.display(viewModel)
        }
    }
    
    private func getMeteorites() -> [Meteorite] {
        guard let currentFilter else {
            return meteorites
        }
        return model.filterMeteorites(meteorites: meteorites, filter: currentFilter)
    }
    
    private func getIsFilterActive() -> Bool {
        currentFilter != nil
    }
}

extension MapDataController: MapViewDataControllerDelegate {
    func didTapSettings() {
        coordinator.displaySetting(initialData: .init(meteorites: meteorites, currentFilter: currentFilter, filterDelegate: self))
    }
    
    func meteorSelected(meteor: Meteorite) {
        coordinator.displayDetailMeteorite(initialData: .init(meteorite: meteor))
    }
    
    func didTapMainButton() {
        if currentFilter == nil {
            model.requestMeteors()
        } else {
            currentFilter = nil
            presentViewModel()
        }
    }
}

extension MapDataController: MapViewModelDataControllerDelegate {
    
}

extension MapDataController: MapModelDataControllerDelegate {
    func updateMeteors(meteors: [Meteorite]) {
        self.meteorites = meteors
        presentViewModel()
    }
    
    func presentError(_ error: Error) {
        if let error = error as? ApiError {
            view?.display(alert: .init(title: "Error", message: error.errorDescription, style: .alert)) }
        else {
            view?.display(alert: .init(title: "Error", message: error.localizedDescription, style: .alert))
        }
    }
}
extension MapDataController: FilterDelegate {
    func filtersSelected(filter: Filter) {
        currentFilter = filter
        presentViewModel()
    }
}
