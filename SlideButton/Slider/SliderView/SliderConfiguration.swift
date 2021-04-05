import UIKit

struct SliderConfiguration {
    var text: String
    var textColor: UIColor? // default black
    
    var backgroundColor: UIColor
    
    var sliderIcon: UIImage? // default nil
    var sliderIconColor: UIColor? // default white
    var sliderBackgroundColor: UIColor
    
    var slidingText: String? // default above text
    var slidingTextColor: UIColor? // default white
    var slidingBackgroundColor: UIColor? // default above backgroundColor 20% darker
    
    init(text: String, backgroundColor: UIColor, sliderBackgroundColor: UIColor) {
        self.text = text
        self.backgroundColor = backgroundColor
        self.sliderBackgroundColor = sliderBackgroundColor
    }
}
