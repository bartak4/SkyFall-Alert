import Foundation

/// Connection data controller -> model controller
protocol MapDataModelControllerDelegate: AnyObject {
    var initialData: MapInitialData { get }
    func requestMeteors()
    func filterMeteorites(meteorites: [Meteorite], filter: Filter) -> [Meteorite]
}

final class MapModelController {
    
    weak var delegate: MapModelDataControllerDelegate?
    
    var initialData: MapInitialData
    
    let meteorMapper: MeteorMapperType = MeteorMapper()
    let networkingService: NetworkingServiceType = NetworkingService()

    required init(initialData: MapInitialData) {
        self.initialData = initialData
    }
}

extension MapModelController: MapDataModelControllerDelegate {
    func requestMeteors() {
        networkingService.request(endpoint: .general).done { meteorResponse in
            let meteors = self.meteorMapper.mapMeteoreResponseToMeteorite(meteoriteResponse: meteorResponse)
            self.delegate?.updateMeteors(meteors: meteors)
        }.catch { error in
            self.delegate?.presentError(error)
        }
    }
    
    func filterMeteorites(meteorites: [Meteorite], filter: Filter) -> [Meteorite] {
        meteorites
            .filter({ $0.year >= Int(filter.minYear) && $0.mass >= Int(filter.minMass)})

    }
}
