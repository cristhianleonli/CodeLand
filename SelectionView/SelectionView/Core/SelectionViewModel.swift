import UIKit

class SelectionViewModel {
    
    // MARK: - Properties
    
    private var items: [SelectionItem] = []
    
    var configuration: SelectionViewConfiguration?
    var itemsWillChange: ItemsChangedHandler?
    var itemsDidChange: ItemsChangedHandler?
}

extension SelectionViewModel {
    func removeItems() {
        items.removeAll()
    }
    
    func multiselect(selected model: SelectionItemModel) {
        var selected: SelectionItem?
        var othersCount = 0
        
        for button in items {
            guard let itemViewModel = button.viewModel else {
                continue
            }
            
            if itemViewModel == model {
                selected = button
            } else {
                if itemViewModel.isSelected {
                    othersCount += 1
                }
            }
        }
        
        guard var buttonViewModel = selected?.viewModel else {
            return
        }
        
        // if user wants to unselect it
        if buttonViewModel.isSelected {
            // check if it's the only one selected, if so, don't unselect it
            if othersCount > 0 {
                buttonViewModel.isSelected = false
            }
        } else {
            // if user wants to select it, then just do it
            buttonViewModel.isSelected = true
        }
        
        // set the viewModel to trigger the redraw action
        selected?.viewModel = buttonViewModel
    }
    
    func markAsSelected(selected model: SelectionItemModel) {
        items.forEach { (button) in
            guard var buttonViewModel = button.viewModel else {
                return
            }
            
            buttonViewModel.isSelected = buttonViewModel == model
            button.viewModel = buttonViewModel
        }
    }
    
    func createItemsViews() -> [SelectionItem] {
        guard let model = configuration else {
            return []
        }
        
        // map the items
        let models = model.options.map { option -> SelectionItemModel in
            var newOption = option
            
            newOption.selectedColor = model.selectedColor
            newOption.unselectedColor = model.unselectedColor
            
            return newOption
        }
        
        // create the views and add the tap event
        let result = models.map { model -> SelectionItem in
            let button = SelectionItem()
            button.viewModel = model
            
            button.onTouch = { [weak self] in
                self?.itemSelected(model)
            }
            
            return button
        }
        
        // save the buttons references
        items = result
        return result
    }
    
    func itemSelected(_ model: SelectionItemModel) {
        guard let config = configuration else {
            return
        }
        
        itemsWillChange?(items.compactMap { $0.viewModel })
        
        // if multiselection is disabled
        // then just mark as selected the item
        // and disbale the rest
        guard config.multipleSelection else {
            markAsSelected(selected: model)
            itemsDidChange?(items.compactMap { $0.viewModel })
            return
        }
        
        // if multiselection is enabled
        multiselect(selected: model)
        itemsDidChange?(items.compactMap { $0.viewModel })
    }
}
