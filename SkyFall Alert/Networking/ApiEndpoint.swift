//
//  ApiEndpoint.swift
//  SkyFall Alert
//
//  Created by Bartak, Marek on 24.02.23.
//

import Foundation

enum ApiEndpoint {
    case general
}

extension ApiEndpoint {
    var path: String {
        switch self {
            case .general:
                return "https://data.nasa.gov/resource/gh4g-9sfh.json"
        }
    }
    
    var method: String {
        switch self {
            case .general:
                return "GET"
        }
    }
    
    var authorization: APIAuthorization {
        switch self {
            case .general:
                return .appToken
        }
    }
}
