import UIKit

class Joystick: UIView {
    
    // MARK: - Properties
    
    let container = UIView()
    let stick = UIView()
    
    var stickYConstraint: NSLayoutConstraint!
    var stickXConstraint: NSLayoutConstraint!
    
    var arrows: [UIImageView] = []
    
    var mainColor: UIColor = .lightGray {
        didSet {
            updateUI()
        }
    }
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateUI()
    }
}

private extension Joystick {
    func updateUI() {
        container.layer.cornerRadius = container.frame.width / 2
        container.layer.borderColor = mainColor.cgColor
        container.layer.borderWidth = 3
        
        stick.layer.cornerRadius = stick.frame.width / 2
        stick.layer.borderColor = mainColor.cgColor
        stick.layer.borderWidth = 2
        
        stick.backgroundColor = mainColor
        
        arrows.forEach { arrow in
            arrow.image = arrow.image?.tintedImage(imageColor: mainColor)
        }
    }
}
