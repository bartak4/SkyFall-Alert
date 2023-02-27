//
//  MeteorMapper.swift
//  SkyFall Alert
//
//  Created by Bartak, Marek on 25.02.23.
//

import Foundation
import CoreLocation

protocol MeteorMapperType {
    func mapMeteoreResponseToMeteorite(meteoriteResponse: [MeteorResponse]) -> [Meteorite]
}

class MeteorMapper {
    private func getYear(isoDate: String) -> Int {
        if isoDate.count > 4 {
            let index = isoDate.index(isoDate.startIndex, offsetBy: 4)
            return Int(String(isoDate.prefix(upTo: index))) ?? 0
        }
        return 0
    }
}

extension MeteorMapper: MeteorMapperType {
    
    func mapMeteoreResponseToMeteorite(meteoriteResponse: [MeteorResponse]) -> [Meteorite] {
        meteoriteResponse.map {
            Meteorite(name: $0.name,
                      id: Int($0.id) ?? 0,
                      mass: Int(Double($0.mass ?? "") ?? 0),
                      year: getYear(isoDate: $0.year ?? ""),
                      coordinate: .init(latitude: Double($0.reclat ?? "") ?? 0.0, longitude: Double($0.reclong ?? "") ?? 0.0))
        }
        .filter({ $0.mass != 0 })
        .filter({ $0.year != 0 })
        
        
    }
}
