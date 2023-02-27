//
//  ApiError.swift
//  SkyFall Alert
//
//  Created by Bartak, Marek on 24.02.23.
//

import Foundation

enum ApiError: Error {
    case unknownError
    case apiError(messageValue: String, status: Int)
    case apiErrorContent(error: Error?, content: Data?, status: Int?)
    case parsing(data: Data?, status: Int)
    
    var errorDescription: String {
        switch self {
            case .unknownError:
                return "Unknown problem. Please contact the developers to resolve this bug.\nEmail: M.Bartak4@gmail.com"
            case .apiError(_, let status), .parsing(_ , let status):
                return "Unknown problem. Please contact the developers to resolve this bug.\nEmail: M.Bartak4@gmail.com \nStatus:\(status)"
            case .apiErrorContent(let error, _, _):
                if (error as? NSError)?.code == NSURLErrorNotConnectedToInternet {
                    return "Device is not connected to the internet."
                } else {
                    return "Unknown problem. Please contact the developers to resolve this bug.\nEmail: M.Bartak4@gmail.com"
                }
        }
    }
}
