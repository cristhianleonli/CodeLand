import UIKit

struct SelectionItemModel: CustomStringConvertible {
    
    // MARK: - Private methods
    
    var title: String
    var image: UIImage
    
    var selectedColor: UIColor = .darkGray
    var unselectedColor: UIColor = .lightGray
    
    var isSelected: Bool = false
    
    // MARK: - Life Cycle
    
    init(title: String, image: UIImage) {
        self.title = title
        self.image = image
    }
    
    init(title: String, image: UIImage, isSelected: Bool) {
        self.title = title
        self.image = image
        self.isSelected = isSelected
    }
    
    var description: String {
        return "ButtonModel (title: \(title), (isSelected: \(isSelected))"
    }
}

// MARK: - Equatable Behaviour

extension SelectionItemModel: Equatable {
    static func == (lhs: SelectionItemModel, rhs: SelectionItemModel) -> Bool {
        return lhs.title.lowercased() == rhs.title.lowercased()
    }
}
