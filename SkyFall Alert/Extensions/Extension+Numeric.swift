//
//  Extension+Numeric.swift
//  SkyFall Alert
//
//  Created by Bartak, Marek on 27.02.23.
//

import Foundation

extension Numeric {
    var formattedWithSeparator: String { Formatter.withSeparator.string(for: self) ?? "" }
}
