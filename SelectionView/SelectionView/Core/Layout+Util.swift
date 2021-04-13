import UIKit

extension UIView {
    enum AnchorDimension {
        case height
        case width
    }
    
    func autoPinEdgesToSuperviewEdges(with insets: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        guard let parent = superview else {
            return
        }
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: parent.topAnchor, constant: insets.top),
            leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: insets.left),
            trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: -insets.right),
            bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: -insets.bottom)
            ])
    }
    
    func autoMatch(_ first: AnchorDimension, to second: AnchorDimension, of other: UIView,
                   withMultiplier multiplier: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        
        let firstAnchor = first == .width ? widthAnchor : heightAnchor
        let secondAnchor = second == .width ? other.widthAnchor : other.heightAnchor
        
        firstAnchor.constraint(equalTo: secondAnchor, multiplier: multiplier).isActive = true
    }
}
