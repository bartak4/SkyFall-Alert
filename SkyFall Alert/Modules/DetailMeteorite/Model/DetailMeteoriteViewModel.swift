import Foundation
import MapKit

/// ViewModel is read-only class, take it as a structure, just a current data snapshot for the view to display it, view state is heald in 'DetailMeteoriteDataController' that fills that view model
final class DetailMeteoriteViewModel {
        
    private weak var delegate: DetailMeteoriteViewModelDataControllerDelegate?
    
    let meteorite: Meteorite
    var cellViewModels: [DetailMeteoriteCellViewModel] = []
    
    required init(delegate: DetailMeteoriteViewModelDataControllerDelegate, metorite: Meteorite) {
        self.delegate = delegate
        self.meteorite = metorite
        self.cellViewModels = prepareCellsViewModel(meteorite: metorite)
    }
    
    private func getFormattedMass(mass: Int) -> String {
        "\(mass.formattedWithSeparator) g"
        
    }
    
    private func prepareCellsViewModel(meteorite: Meteorite) -> [DetailMeteoriteCellViewModel] {
        [
            .init(components: [.leftText(description: "Name:"),
                               .rightText(value: meteorite.name ?? "")]),
            .init(components: [.leftText(description: "ID:"),
                               .rightText(value: String(meteorite.id))]),
            .init(components: [.leftText(description: "Mass:"),
                               .rightText(value: getFormattedMass(mass:meteorite.mass))]),
            .init(components: [.leftText(description: "Year:"),
                               .rightText(value: String(meteorite.year))]),
            .init(components: [.image(image: meteorite.image, classification: meteorite.classification)]),
        ]
    }
}


extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        return formatter
    }()
}

extension Numeric {
    var formattedWithSeparator: String { Formatter.withSeparator.string(for: self) ?? "" }
}
