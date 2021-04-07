# SliderView

| Regular | Finished | In action |
| ------ | ------ | ------ |
| ![regular](https://github.com/cristhianleonli/codeland/blob/main/SlideButton/screenshots/screen_1.png) | ![finished](https://github.com/cristhianleonli/codeland/blob/main/SlideButton/screenshots/screen_2.png) | <img src="https://github.com/cristhianleonli/codeland/blob/main/SlideButton/screenshots/quick_video.gif" width="900"> |

## What's in the box
- SliderView.swift
- SliderConfiguration.swift

## How to use it

```swift
import UIKit

class ViewController: UIViewController {

    @IBOutlet private var slideView: SliderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSlider()
    }
}

private extension ViewController {
    func setupSlider() {
        let mainColor = UIColor.create(0, 1, 42)
        
        var config = SliderConfiguration(
            text: "PAY €6.50",
            backgroundColor: UIColor.create(224, 223, 230),
            sliderBackgroundColor: mainColor
        )
        
        config.textColor = mainColor
        config.sliderIcon = UIImage(named: "arrow")
        
        // set the configuration object
        slideView.configuration = config
        
        // Closure when the slider max point is reached
        slideView.onMaxSlide = {
            print("Slider moved all the way to the end")
        }
    }
}
```
