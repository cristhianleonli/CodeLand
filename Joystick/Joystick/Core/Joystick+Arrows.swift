import UIKit
import Foundation

extension Joystick {
    func addArrow(_ type: ArrowType) -> UIImageView {
        let arrow = UIImageView()
        
        addSubview(arrow)
        arrow.translatesAutoresizingMaskIntoConstraints = false
        
        let sideConstraint: NSLayoutConstraint = {
            switch type {
            case .left:
                return arrow
                    .leadingAnchor
                    .constraint(equalTo: leadingAnchor, constant: 6)
            case .right:
                return arrow
                    .trailingAnchor
                    .constraint(equalTo: trailingAnchor, constant: -6)
            case .top:
                return arrow
                    .topAnchor
                    .constraint(equalTo: topAnchor, constant: 6)
            case .down:
                return arrow
                    .bottomAnchor
                    .constraint(equalTo: bottomAnchor, constant: -6)
            }
        }()
        
        let alignConstraint: NSLayoutConstraint = {
            switch type {
            case .left, .right:
                return arrow
                    .centerYAnchor
                    .constraint(equalTo: centerYAnchor)
            case .top, .down:
                return arrow
                    .centerXAnchor
                    .constraint(equalTo: centerXAnchor)
            }
        }()
        
        NSLayoutConstraint.activate([
            sideConstraint,
            alignConstraint,
            arrow.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.1),
            arrow.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1)
            ])
        
        arrow.image = UIImage(named: "\(type)_arrow")?.tintedImage(imageColor: mainColor)
        return arrow
    }
}
