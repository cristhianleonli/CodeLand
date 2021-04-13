# SelectionView

| Single | Multiple | Both |
| ------ | ------ | ------ |
| ![launch](https://github.com/cristhianleonli/codeland/tree/main/SelectionView/screenshots/screen_1.png) | ![launch](https://github.com/cristhianleonli/codeland/tree/main/SelectionView/screenshots/screen_2.png) | <img src="https://github.com/cristhianleonli/codeland/tree/main/SelectionView/screenshots/quick_video.gif" width="900"> |

## What's in the box
- `Core/SelectionView.swift`
- `Core/SelectionViewModel.swift`
- `Core/SelectionItem.swift`
- `Core/SelectionItemModel.swift`
- `Core/SelectionViewConfiguration.swift`
- `Core/Layout+Util.swift`

## Usage

```swift
import UIKit

class ViewController: UIViewController {

    @IBOutlet private var selectionView: SelectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSelection()
    }
}

private extension ViewController {
    func setupSelection() {
        // configure the options
        let options = [
            SelectionItemModel(title: "Reports", image: Images.board),
            SelectionItemModel(title: "Files", image: Images.file),
            SelectionItemModel(title: "Gestures", image: Images.hand),
            SelectionItemModel(title: "Sports", image: Images.shoe),
            SelectionItemModel(title: "Weather", image: Images.temp)
        ]

        selectionView.configuration = SelectionViewConfiguration(
            options: options,
            selectedColor: UIColor(red: 53/255, green: 59/255, blue: 81/255, alpha: 1),
            unselectedColor: .white,
            multipleSelection: true
        )
        
        // event when items in the list changed
        selectionView.itemsDidChange = { models in
            models.forEach { print($0) }
        }
    }
}
```
