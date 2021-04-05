import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet private var slideView: SliderView!
    @IBOutlet private var slideView2: SliderView!
    @IBOutlet private var slideView3: SliderView!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSlider1()
        setupSlider2()
        setupSlider3()
    }
}

private extension ViewController {
    func setupSlider1() {
        let mainColor = UIColor.create(0, 1, 42)
        
        var config = SliderConfiguration(
            text: "PAY €6.50",
            backgroundColor: UIColor.create(224, 223, 230),
            sliderBackgroundColor: mainColor
        )
        
        config.textColor = mainColor
        config.sliderIcon = UIImage(named: "arrow")
        
        slideView.configuration = config
        
        slideView.onMaxSlide = { [weak self] in
            self?.showAlert(
                message: "We have successfully received your payment, your order will be delivered in approx. 30 minutes",
                slider: self?.slideView
            )
        }
    }
    
    func setupSlider2() {
        let mainColor = UIColor.create(224, 223, 230)
        
        var config = SliderConfiguration(
            text: "Slide to cancel",
            backgroundColor: mainColor,
            sliderBackgroundColor: UIColor.create(0, 1, 42)
        )
        
        config.sliderIcon = UIImage(named: "delete")
        config.sliderIconColor = .white
        config.sliderBackgroundColor = UIColor.create(1, 87, 148)
        config.slidingText = "CANCEL"
        
        slideView2.configuration = config
        
        slideView2.onMaxSlide = { [weak self] in
            self?.showAlert(
                message: "We're sorry that you have cancel the request.\nYou can change your mind at anytime",
                slider: self?.slideView2
            )
        }
    }
    
    func setupSlider3() {
        var config = SliderConfiguration(
            text: "Swipe to lock",
            backgroundColor: UIColor.create(224, 223, 230),
            sliderBackgroundColor: UIColor.create(40, 179, 81)
        )
        
        config.slidingText = "Lock"
        config.sliderIcon = UIImage(named: "lock")
        config.slidingBackgroundColor = UIColor.create(97, 219, 133)
        config.slidingTextColor = .black
        
        slideView3.configuration = config
        
        slideView3.onMaxSlide = { [weak self] in
            self?.showAlert(
                message: "You have lock the credit cards on your wallet",
                slider: self?.slideView3
            )
        }
    }
    
    func showAlert(message: String, slider: SliderView?) {
        let controller = UIAlertController(
            title: "Message",
            message: message,
            preferredStyle: .actionSheet
        )
        
        let alert = UIAlertAction(title: "Close", style: .default, handler: { _ in
            slider?.resetSlider()
        })
        
        controller.addAction(alert)
        present(controller, animated: true)
    }
}
