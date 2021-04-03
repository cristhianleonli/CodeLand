import Foundation
import UIKit

struct NavigationModel {
    
    var title: String
    var icon: UIImage
    var item: Item
}

extension NavigationModel {
    enum Item: CaseIterable {
        case home
        case keys
        case messages
        case settings
        case timer
    }
}
