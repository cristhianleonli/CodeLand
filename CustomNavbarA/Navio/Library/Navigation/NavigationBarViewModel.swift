import UIKit
import Foundation

struct NavigationBarViewModel {
    
}

extension NavigationBarViewModel {
    func navigationModels() -> [NavigationModel] {
        return [
            NavigationModel(
                title: "Home",
                icon: Images.home_icon()!,
                item: .home
            ),
            NavigationModel(
                title: "Timer",
                icon: Images.timer_icon()!,
                item: .timer
            ),
            NavigationModel(
                title: "Keys",
                icon: Images.key_icon()!,
                item: .keys
            ),
            NavigationModel(
                title: "Messages",
                icon: Images.messages_icon()!,
                item: .messages
            ),
            NavigationModel(
                title: "Settings",
                icon: Images.settings_icon()!,
                item: .settings
            )
        ]
    }
}
