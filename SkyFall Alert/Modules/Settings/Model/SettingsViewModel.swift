import Foundation

/// ViewModel is read-only class, take it as a structure, just a current data snapshot for the view to display it, view state is heald in 'SettingsDataController' that fills that view model
final class SettingsViewModel {
        
    private weak var delegate: SettingsViewModelDataControllerDelegate?
    
    let title = "Filters"
    let confirmButtonTitle = "Confirm filter"
    
    let massTitle: String = "Minimum mass"
    var massMin: Float = 0
    var massMax: Float = 0
    
    let yearTitle: String = "Minimum year of impact"
    var minYear: Float = 0
    var maxYear: Float = 0
    
    let currentFilterMass: Float
    let currentFilterYears: Float
    
    required init(delegate: SettingsViewModelDataControllerDelegate, meteorites: [Meteorite], currentFilter: Filter?) {
        self.delegate = delegate
        self.currentFilterMass = currentFilter?.minMass ?? 0
        self.currentFilterYears = currentFilter?.minYear ?? 0
        setupDataForMassSlider(meteorites: meteorites)
        setupDataForYearsSlider(meteorites: meteorites)
    }
    
    private func setupDataForMassSlider(meteorites: [Meteorite]) {
        guard let firstMeteorite = meteorites.first else { return }
        
        var largestMeteorite = firstMeteorite
        var smallestMeteorite = firstMeteorite
        
        for meteorite in meteorites {
            if meteorite.mass > largestMeteorite.mass {
                largestMeteorite = meteorite
            }
            if meteorite.mass < smallestMeteorite.mass {
                smallestMeteorite = meteorite
            }
        }
        massMin = Float(smallestMeteorite.mass)
        massMax = Float(largestMeteorite.mass)
    }
    
    private func setupDataForYearsSlider(meteorites: [Meteorite]) {
        guard let firstMeteorite = meteorites.first else { return }
        
        var youngestMeteorite = firstMeteorite
        var oldestMeteorite = firstMeteorite
        
        for meteorite in meteorites {
            if meteorite.year > oldestMeteorite.year {
                oldestMeteorite = meteorite
            }
            if meteorite.year < youngestMeteorite.year {
                youngestMeteorite = meteorite
            }
        }
        minYear = Float(youngestMeteorite.year)
        maxYear = Float(oldestMeteorite.year)
    }
}

