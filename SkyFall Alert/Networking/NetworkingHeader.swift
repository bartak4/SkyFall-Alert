//
//  NetworkingHeader.swift
//  SkyFall Alert
//
//  Created by Bartak, Marek on 24.02.23.
//

import Foundation

enum NetworkingHeader {
    case appToken
    
    var headerName: String {
        switch self {
            case .appToken:
                return "X-App-Token"
        }
    }
    
    var headerValue: String {
        switch self {
            case .appToken:
                return "zWtZYZ4QCXY4eKa8LOHnnXRSP"
        }
    }
}
