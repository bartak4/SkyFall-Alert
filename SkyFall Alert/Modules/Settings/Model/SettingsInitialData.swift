import Foundation

/// Data needed to reference from another view controller
/// # Example #
/// ```
/// struct SettingsInitialData {
///     let transactionId: String
/// }
/// ```
struct SettingsInitialData {
    let meteorites: [Meteorite]
    let currentFilter: Filter?
    let filterDelegate: FilterDelegate
}

protocol FilterDelegate {
    func filtersSelected(filter: Filter)
}

struct Filter {
    let minMass: Float
    let minYear: Float
}
