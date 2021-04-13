import UIKit
import Foundation

class MainViewModel {
    
    private var options: [SelectionItemModel] {
        return [
            SelectionItemModel(title: "Reports", image: Images.icon1, isSelected: true),
            SelectionItemModel(title: "Files", image: Images.icon2),
            SelectionItemModel(title: "Gestures", image: Images.icon3),
            SelectionItemModel(title: "Sports", image: Images.icon4),
            SelectionItemModel(title: "Weather", image: Images.icon5)
        ].shuffled()
    }
    
    // configuration for SelectionView
    func selectionConfig(multiple: Bool) -> SelectionViewConfiguration {
        return SelectionViewConfiguration(
            options: options,
            selectedColor: selectionColor,
            unselectedColor: .white,
            multipleSelection: multiple
        )
    }
    
    // main view background color
    var backgroundColor: UIColor {
        return UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
    }
    
    // main accent color
    var selectionColor: UIColor {
        return  UIColor(red: 53/255, green: 59/255, blue: 81/255, alpha: 1)
    }
}
