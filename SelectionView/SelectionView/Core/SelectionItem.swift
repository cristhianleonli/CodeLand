import UIKit

typealias TapEventHandler = () -> Void

class SelectionItem: UIView {
    
    // MARK: - Properties
    
    var onTouch: TapEventHandler?
    
    private let container = UIStackView()
    private let titleLabel = UILabel()
    private let iconImageView = UIImageView()
    private let topButton = UIButton()
    private var animationDuration: TimeInterval = 0.0
    
    var viewModel: SelectionItemModel? {
        didSet {
            if let model = viewModel {
                fillData(model: model, duration: animationDuration)
                animationDuration = 0.15
            }
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
        layer.cornerRadius = 4
    }
}

// MARK: - Private methods

private extension SelectionItem {
    func setupView() {
        addSubview(container)
        
        let margin = UIEdgeInsets(top: 5, left: 2, bottom: 5, right: 2)
        container.autoPinEdgesToSuperviewEdges(with: margin)
        
        container.axis = .vertical
        container.alignment = .center
        container.spacing = 3
        
        // Icon image view
        container.addArrangedSubview(iconImageView)
        iconImageView.autoMatch(.height, to: .height, of: container, withMultiplier: 0.65)
        iconImageView.autoMatch(.width, to: .height, of: container, withMultiplier: 0.65)
        
        iconImageView.contentMode = .scaleAspectFit
        
        // title label
        container.addArrangedSubview(titleLabel)
        titleLabel.font = UIFont.systemFont(ofSize: 11)
        
        // button
        addSubview(topButton)
        topButton.autoPinEdgesToSuperviewEdges()
        topButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func buttonTapped(_ sender: Any) {
        onTouch?()
    }
    
    func fillData(model: SelectionItemModel, duration: TimeInterval) {
        titleLabel.text = model.title
        
        if model.isSelected {
            animate(shrink: true, duration: duration)
            backgroundColor = model.selectedColor
            titleLabel.textColor = model.unselectedColor
            iconImageView.image = model.image.tintedImage(imageColor: model.unselectedColor)
        } else {
            animate(shrink: false, duration: duration)
            backgroundColor = model.unselectedColor
            titleLabel.textColor = model.selectedColor
            iconImageView.image = model.image.tintedImage(imageColor: model.selectedColor)
        }
    }
    
    func animate(shrink: Bool, duration: TimeInterval) {
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseIn, animations: {
            if shrink {
                self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            } else {
                self.transform = .identity
            }
        }, completion: nil)
    }
}
