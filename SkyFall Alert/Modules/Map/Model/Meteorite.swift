//
//  Meteorite.swift
//  SkyFall Alert
//
//  Created by Bartak, Marek on 23.02.23.
//

import Foundation
import MapKit
import Contacts

class Meteorite: NSObject, MKAnnotation {
    let name: String?
    let id: Int
    let mass: Int
    let year: Int
    let coordinate: CLLocationCoordinate2D
    
    
    init(name: String?, id: Int, mass: Int, year: Int, coordinate: CLLocationCoordinate2D) {
        self.name = name
        self.id = id
        self.mass = mass
        self.year = year
        self.coordinate = coordinate
    }
    
    var mapItem: MKMapItem? {
        guard let name = name else {
            return nil
        }
        let addressDict = [CNPostalAddressStreetKey: coordinate]
        let placemark = MKPlacemark(
            coordinate: coordinate,
            addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = name
        return mapItem
    }
    
    var image: UIImage {
        switch mass {
            case 1...1000:
                return UIImage(named: "meteorSmall")!
            case 1001...10000:
                return UIImage(named: "meteorMedium")!
            case 10001...10000000000:
                return UIImage(named: "meteorBig")!
            default:
                return UIImage(named: "meteorSmall")!
        }
    }
    
    var classification: String {
        switch mass {
            case 1...1000:
                return "lower class (1 to 1 000 grams)"
            case 1001...10000:
                return "medium class (1 000 to 10 000 grams)"
            case 10001...10000000000:
                return "heavy class (over 10 000 grams)"
            default:
                return ""
        }
    }
}

class MeteorView: MKAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            guard let meteor = newValue as? Meteorite else {
                return
            }
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            let mapsButton = UIButton(type: .detailDisclosure)
            rightCalloutAccessoryView = mapsButton
            image = meteor.image.resize(width: 20, height: 20)
            
            let detailLabel = UILabel()
            detailLabel.numberOfLines = 0
            detailLabel.font = detailLabel.font.withSize(12)
            detailLabel.text = meteor.name
            detailCalloutAccessoryView = detailLabel
        }
    }

}
