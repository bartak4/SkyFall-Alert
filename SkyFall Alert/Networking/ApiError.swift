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
    case parsing(data: Data?, status: Int?)
}
