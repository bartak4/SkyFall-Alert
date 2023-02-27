//
//  Meteor.swift
//  SkyFall Alert
//
//  Created by Bartak, Marek on 24.02.23.
//

import Foundation

struct MeteorResponse: Codable {
    let name: String
    let id: String
    let nametype: String
    let recclass: String
    let mass: String?
    let fall: String
    let year: String?
    let reclat: String?
    let reclong: String?
    let geolocation: Geolocation?
}

struct Geolocation: Codable {
    let latitude: String
    let longitude: String
}
