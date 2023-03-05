import Foundation

/// ViewModel is read-only class, take it as a structure, just a current data snapshot for the view to display it, view state is heald in 'MapDataController' that fills that view model
final class MapViewModel {
        
    private weak var delegate: MapViewModelDataControllerDelegate?
    
    var meteorites: [Meteorite] = []
    let isFilterActive: Bool
    var resultTitle: String = ""
    var mainButtonTitle: String {
        switch isFilterActive {
            case true:
                return "Filter Reset"
            case false:
                return "Search meteorites"
        }
    }
    
    required init(delegate: MapViewModelDataControllerDelegate, meteorites: [Meteorite], isFilterActive: Bool) {
        self.delegate = delegate
        self.meteorites = meteorites
        self.isFilterActive = isFilterActive
        setResultTitle()
    }
    
    private func setResultTitle() {
        let plural = meteorites.count == 1 ? "" : "s"
        resultTitle = "   Result \(meteorites.count) meteorite\(plural)   "
    }
}
