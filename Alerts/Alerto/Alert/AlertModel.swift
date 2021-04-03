import Foundation

enum AutoCloseDuration: CaseIterable {
    case none
    case quick
    case long
    
    // can be extended for custom duration
}

struct AlertModel {
    
    // MARK: - Properties
    
    var title: String = ""
    var message: String = ""
    var primaryButton: String? = ""
    var secondaryButton: String? = ""
    var isDismissable: Bool = false
    var autoCloseDuration: AutoCloseDuration
}
