import UIKit

class ViewController: UIViewController {
    
    private let viewModel = ViewModel()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = viewModel.titleText
        return label
    }()
    
    lazy var createButton: UIButton = {
        let button = UIButton()
        button.setTitle(viewModel.createButtonTitle, for: .normal)
        return button
    }()
    
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.text = viewModel.messageText
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Imagine we've added the button & label to the view hierarchy
    }
}
