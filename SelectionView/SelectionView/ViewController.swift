import UIKit

class ViewController: UIViewController {

    @IBOutlet private var selectionViewSingle: SelectionView!
    @IBOutlet private var selectionViewMultiple: SelectionView!
    
    private let viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = viewModel.backgroundColor
        
        setupSingleSelection()
        setupMultipleSelection()
    }
}

private extension ViewController {
    func setupSingleSelection() {
        selectionViewSingle.configuration = viewModel.selectionConfig(multiple: false)
        
        // event when items in the list changed
        selectionViewSingle.itemsDidChange = { models in
            models.forEach { print($0) }
        }
    }
    
    func setupMultipleSelection() {
        selectionViewMultiple.configuration = viewModel.selectionConfig(multiple: true)
        
        // event when items in the list changed
        selectionViewMultiple.itemsDidChange = { models in
            models.forEach { print($0) }
        }
    }
}
