import UIKit
import Foundation

class NavigationBar: UIView, Reusable {
    
    // MARK: - Outlets
    
    @IBOutlet private var contentView: UIView!
    @IBOutlet private var elementsStack: UIStackView!
    
    // MARK: - Properties
    
    private let viewModel: NavigationBarViewModel = NavigationBarViewModel()
    
    // MARK: - Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
}

private extension NavigationBar {
    /// Initialize the view from xib file
    func commonInit() {
        Bundle.main.loadNibNamed(NavigationBar.reuseId, owner: self, options: nil)
        
        addSubview(self.contentView)
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.contentView.topAnchor.constraint(equalTo: self.topAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        self.setupUI()
    }
    
    func setupUI() {
        backgroundColor = .lightGray
        addShadow()
        
        elementsStack.arrangedSubviews.first?.removeFromSuperview()
        
        for element in viewModel.navigationModels() {
            let navElement = NavigationElement()
            navElement.translatesAutoresizingMaskIntoConstraints = false
            
            elementsStack.addArrangedSubview(navElement)
            
            NSLayoutConstraint.activate([
                navElement.widthAnchor.constraint(equalToConstant: 50),
                navElement.heightAnchor.constraint(equalToConstant: 50)
            ])
            
            navElement.model = element
            navElement.onSelect = { [weak self] in
                self?.select(item: element.item)
            }
        }
        
        select(item: .home)
    }
    
    func select(item: NavigationModel.Item) {
        let elements = elementsStack.arrangedSubviews.compactMap { $0 as? NavigationElement }
        
        for element in elements {
            if element.model.item == item {
                element.makeImageSelected()
            } else {
                element.makeImageUnselected()
            }
        }
    }
    
    func addShadow() {
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = .zero
        layer.shadowRadius = 1
    }
}
