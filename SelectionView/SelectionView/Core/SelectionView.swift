import UIKit

typealias ItemsChangedHandler = ([SelectionItemModel]) -> Void

class SelectionView: UIView {
    
    // MARK: - Properties
    
    private let viewModel = SelectionViewModel()
    private let stackContainer = UIStackView()
    
    var itemsWillChange: ItemsChangedHandler? {
        didSet {
            viewModel.itemsWillChange = itemsWillChange
        }
    }
    
    var itemsDidChange: ItemsChangedHandler? {
        didSet {
            viewModel.itemsDidChange = itemsDidChange
        }
    }
    
    var configuration: SelectionViewConfiguration? {
        didSet {
            fillData(configuration: configuration)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
}

private extension SelectionView {
    func setupView() {
        backgroundColor = .clear
        addSubview(stackContainer)
        
        let margin = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        stackContainer.autoPinEdgesToSuperviewEdges(with: margin)
        
        stackContainer.axis = .horizontal
        stackContainer.spacing = 8
        stackContainer.distribution = .fillEqually
    }
    
    func fillData(configuration: SelectionViewConfiguration?) {
        // clean stackView, removing SelectionItem's
        stackContainer.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        // settings the new configuration(model)
        viewModel.configuration = configuration
        
        // removing the old items
        viewModel.removeItems()
        
        // create buttons views
        let items = viewModel.createItemsViews()
        
        // add them to the stack view
        items.forEach { (button) in
            stackContainer.addArrangedSubview(button)
        }
    }
}
