//
//  Extension+Formatter.swift
//  SkyFall Alert
//
//  Created by Bartak, Marek on 27.02.23.
//

import Foundation

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        return formatter
    }()
}
