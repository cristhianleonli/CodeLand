import UIKit
import Foundation

typealias SelectionHandler = () -> Void

class NavigationElement: UIView {
    
    // MARK: - Properties
    
    var onSelect: SelectionHandler?
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let pinView = UIView()
    
    private var topConstraint: NSLayoutConstraint?
    
    var model: NavigationModel! {
        didSet {
            if let navModel = model {
                updateUI(model: navModel)
            }
        }
    }
    
    // MARK: - Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupObservers()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        setupObservers()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        pinView.layer.cornerRadius = pinView.frame.height / 2
    }
}

private extension NavigationElement {
    func setupObservers() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped))
        addGestureRecognizer(tapGesture)
        isUserInteractionEnabled = true
    }
    
    @objc func tapped(_ sender: UIGestureRecognizer) {
        onSelect?()
    }
    
    func updateUI(model: NavigationModel) {
        imageView.image = model.icon
        titleLabel.text = model.title
    }
    
    func setupUI() {
        backgroundColor = .clear
        
        addImageView()
        addLabel()
        addPin()
    }
    
    func addImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        
        let imageTopAnchor = imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5)
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            imageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageTopAnchor
        ])
        
        topConstraint = imageTopAnchor
    }
    
    func addLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        titleLabel.font = Fonts.titleLabel
        titleLabel.textAlignment = .center
    }
    
    func addPin() {
        pinView.translatesAutoresizingMaskIntoConstraints = false
        insertSubview(pinView, belowSubview: imageView)
        
        NSLayoutConstraint.activate([
            pinView.widthAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.7),
            pinView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.7),
            pinView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            pinView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor)
        ])
        
        pinView.backgroundColor = Colors.selectedText
    }
}

extension NavigationElement {
    func makeImageSelected() {
        titleLabel.textColor = Colors.selectedText
        imageView.image = imageView.image?.tintedImage(imageColor: Colors.selectedItem)
        
        UIView.animate(withDuration: 0.05, delay: 0, options: .curveEaseOut, animations: {
            self.topConstraint?.isActive = false
            self.topConstraint?.constant = 10
            self.topConstraint?.isActive = true
            self.layoutIfNeeded()
        }) { _ in
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations: {
                self.topConstraint?.isActive = false
                self.topConstraint?.constant = 5
                self.topConstraint?.isActive = true
                self.layoutIfNeeded()
            })
        }
        
        pinView.isHidden = false
    }
    
    func makeImageUnselected() {
        titleLabel.textColor = Colors.unselectedText
        imageView.image = imageView.image?.tintedImage(imageColor: Colors.unselectedItem)
        pinView.isHidden = true
    }
}
