import UIKit
import Foundation

struct Fonts {
    static let titleLabel: UIFont = UIFont(name: "AvenirNext-DemiBold", size: 10)!
}

struct Images {
    static func home_icon() -> UIImage? { return UIImage(named: "home_icon") }
    static func key_icon() -> UIImage? { return UIImage(named: "key_icon") }
    static func messages_icon() -> UIImage? { return UIImage(named: "notifications_icon") }
    static func settings_icon() -> UIImage? { return UIImage(named: "settings_icon") }
    static func timer_icon() -> UIImage? { return UIImage(named: "timer_icon") }
}

struct Colors {
    static let unselectedItem: UIColor = UIColor.create(153, 153, 153)
    static let unselectedText: UIColor = UIColor.create(153, 153, 153)
    
    static let selectedItem: UIColor = UIColor.create(51, 51, 51)
    static let selectedText: UIColor = UIColor.create(247, 204, 50)
}
