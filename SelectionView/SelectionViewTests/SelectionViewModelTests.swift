import XCTest
@testable import SelectionView

class SelectionViewModelTests: XCTestCase {}

extension SelectionViewModelTests {
    func test_SelectItem_SingleSelection_ShouldTurnTrue() {
        let configuration = SelectionViewConfiguration(
            options: [
                SelectionItemModel(title: "title1", image: UIImage()),
                SelectionItemModel(title: "title2", image: UIImage())
            ],
            selectedColor: .red,
            unselectedColor: .blue,
            multipleSelection: false
        )
        
        let viewModel = SelectionViewModel()
        
        viewModel.configuration = configuration
        let items = viewModel.createItemsViews()
        
        viewModel.itemSelected(items[0].viewModel!)
        
        XCTAssertTrue(items[0].viewModel!.isSelected)
        XCTAssertFalse(items[1].viewModel!.isSelected)
    }
    
    func test_SelectItem_SingleSelection_ShouldTurnFalse() {
        let configuration = SelectionViewConfiguration(
            options: [
                SelectionItemModel(title: "title1", image: UIImage(), isSelected: true),
                SelectionItemModel(title: "title2", image: UIImage(), isSelected: true),
                SelectionItemModel(title: "title3", image: UIImage(), isSelected: true)
            ],
            selectedColor: .red,
            unselectedColor: .blue,
            multipleSelection: false
        )
        
        let viewModel = SelectionViewModel()
        
        viewModel.configuration = configuration
        let items = viewModel.createItemsViews()
        
        viewModel.itemSelected(items[0].viewModel!)
        
        XCTAssertTrue(items[0].viewModel!.isSelected)
        XCTAssertFalse(items[1].viewModel!.isSelected)
        XCTAssertFalse(items[2].viewModel!.isSelected)
    }
    
    func test_SelectItem_MultipleSelection_ShouldMatchRoutine() {
        let configuration = SelectionViewConfiguration(
            options: [
                SelectionItemModel(title: "title1", image: UIImage()),
                SelectionItemModel(title: "title2", image: UIImage()),
                SelectionItemModel(title: "title3", image: UIImage())
            ],
            selectedColor: .red,
            unselectedColor: .blue,
            multipleSelection: true
        )
        
        let viewModel = SelectionViewModel()
        
        viewModel.configuration = configuration
        let items = viewModel.createItemsViews()
        
        // select position 0
        viewModel.itemSelected(items[0].viewModel!)
        
        XCTAssertTrue(items[0].viewModel!.isSelected)
        XCTAssertFalse(items[1].viewModel!.isSelected)
        XCTAssertFalse(items[2].viewModel!.isSelected)
        
        // then select position 1
        viewModel.itemSelected(items[1].viewModel!)
        
        XCTAssertTrue(items[0].viewModel!.isSelected)
        XCTAssertTrue(items[1].viewModel!.isSelected)
        XCTAssertFalse(items[2].viewModel!.isSelected)
        
        // finally select position 2, all should be selected
        viewModel.itemSelected(items[2].viewModel!)
        
        XCTAssertTrue(items[0].viewModel!.isSelected)
        XCTAssertTrue(items[1].viewModel!.isSelected)
        XCTAssertTrue(items[2].viewModel!.isSelected)
    }
    
    func test_SelectItem_MultipleSelection_ShouldMatchLastItem() {
        let configuration = SelectionViewConfiguration(
            options: [
                SelectionItemModel(title: "title1", image: UIImage(), isSelected: true),
                SelectionItemModel(title: "title2", image: UIImage(), isSelected: true),
                SelectionItemModel(title: "title3", image: UIImage(), isSelected: true)
            ],
            selectedColor: .red,
            unselectedColor: .blue,
            multipleSelection: true
        )
        
        let viewModel = SelectionViewModel()
        
        viewModel.configuration = configuration
        let items = viewModel.createItemsViews()
        
        // select position 0
        viewModel.itemSelected(items[0].viewModel!)
        
        XCTAssertFalse(items[0].viewModel!.isSelected)
        XCTAssertTrue(items[1].viewModel!.isSelected)
        XCTAssertTrue(items[2].viewModel!.isSelected)
        
        // then select position 1
        viewModel.itemSelected(items[1].viewModel!)
        
        XCTAssertFalse(items[0].viewModel!.isSelected)
        XCTAssertFalse(items[1].viewModel!.isSelected)
        XCTAssertTrue(items[2].viewModel!.isSelected)
        
        // finally select position 2, cannot deselect last item
        viewModel.itemSelected(items[2].viewModel!)
        
        XCTAssertFalse(items[0].viewModel!.isSelected)
        XCTAssertFalse(items[1].viewModel!.isSelected)
        XCTAssertTrue(items[2].viewModel!.isSelected)
    }
}
