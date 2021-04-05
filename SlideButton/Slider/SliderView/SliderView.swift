import UIKit

class SliderView: UIView {
    
    // MARK: - Properties
    
    private let slider = UIView()
    private let sliderIcon = UIImageView()
    
    private let confirmView = UIView()
    private let confirmLabel = UILabel()
    private let titleLabel = UILabel()
    
    private var panGesture: UIPanGestureRecognizer!
    private var sliderConstraint: NSLayoutConstraint!
    
    private var minCenter: CGFloat = 4
    private var maxCenter: CGFloat = 0
    private let multiplier: CGFloat = 0.9
    
    private let titleFont: UIFont? = UIFont(
        name: "AvenirNextCondensed-Medium",
        size: 20
    )
    
    typealias MaxSlideClosure = () -> Void
    var onMaxSlide: MaxSlideClosure?
    
    var configuration: SliderConfiguration? {
        didSet {
            if let config = configuration {
                updateUI(configuration: config)
            }
        }
    }
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = frame.height / 2
        
        slider.layer.cornerRadius = slider.frame.height / 2
        confirmView.layer.cornerRadius = confirmView.frame.height / 2
        
        maxCenter = frame.width - frame.height * multiplier - minCenter
    }
}

extension SliderView {
    func resetSlider(animated: Bool = true) {
        moveSlider(to: minCenter, animated: animated)
    }
}

private extension SliderView {
    func setupView() {
        addTitleView()
        addSlider()
        addSlidingView()
    }
    
    func updateUI(configuration: SliderConfiguration) {
        titleLabel.text = configuration.text
        titleLabel.textColor = configuration.textColor ?? .black
        
        backgroundColor = configuration.backgroundColor
        
        sliderIcon.image =
            configuration
            .sliderIcon?
            .tintedImage(imageColor: configuration.sliderIconColor ?? .white)
        
        slider.backgroundColor = configuration.sliderBackgroundColor
        
        confirmLabel.text = configuration.slidingText ?? configuration.text
        confirmLabel.textColor = configuration.slidingTextColor ?? .white
        
        confirmView.backgroundColor = configuration.slidingBackgroundColor ?? configuration.backgroundColor.darker(by: 20)
    }
    
    func addSlider() {
        addSubview(slider)
        slider.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            slider.centerYAnchor.constraint(equalTo: centerYAnchor),
            slider.heightAnchor.constraint(equalTo: heightAnchor, multiplier: multiplier),
            slider.widthAnchor.constraint(equalTo: heightAnchor, multiplier: multiplier)
            ])
        
        sliderConstraint = slider.leadingAnchor.constraint(equalTo: leadingAnchor)
        sliderConstraint.constant = minCenter
        sliderConstraint.isActive = true
        
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(draggedView))
        slider.isUserInteractionEnabled = true
        slider.addGestureRecognizer(panGesture)
        
        // icon image
        slider.addSubview(sliderIcon)
        sliderIcon.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sliderIcon.widthAnchor.constraint(equalTo: slider.widthAnchor, multiplier: 0.4),
            sliderIcon.heightAnchor.constraint(equalTo: slider.heightAnchor, multiplier: 0.4),
            sliderIcon.centerYAnchor.constraint(equalTo: slider.centerYAnchor),
            sliderIcon.centerXAnchor.constraint(equalTo: slider.centerXAnchor),
            ])
    }
    
    func addSlidingView() {
        insertSubview(confirmView, belowSubview: slider)
        confirmView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            confirmView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: minCenter),
            confirmView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: multiplier),
            confirmView.centerYAnchor.constraint(equalTo: centerYAnchor),
            confirmView.trailingAnchor.constraint(equalTo: slider.trailingAnchor)
            ])
        
        // sliding label
        confirmView.addSubview(confirmLabel)
        confirmLabel.translatesAutoresizingMaskIntoConstraints = false
        
        confirmLabel.font = titleFont
        confirmLabel.textAlignment = .center
        confirmLabel.textColor = .white
        confirmLabel.alpha = 0
        
        NSLayoutConstraint.activate([
            confirmLabel.centerYAnchor.constraint(equalTo: confirmView.centerYAnchor),
            confirmLabel.centerXAnchor.constraint(equalTo: confirmView.centerXAnchor)
            ])
    }
    
    func addTitleView() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
        
        titleLabel.font = titleFont
    }
    
    @objc func draggedView(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self)
        
        // calculate the next-move position
        var move: CGFloat = sliderConstraint.constant + translation.x
        
        switch gesture.state {
        case .ended, .cancelled, .failed:
            // if user dropped the slider before the end
            // the, take the slider back to the starting point
            if move < maxCenter {
                move = minCenter
            } else {
                // if the slider reaches the end
                // then executes the callback
                onMaxSlide?()
            }
            
            // move the slider
            moveSlider(to: move, animated: true)
        case .changed:
            // if less than the min, then set the min
            if move < minCenter {
                move = minCenter
            }
            
            // if greater than the max, then set the max
            if move > maxCenter {
                move = maxCenter
            }
            
            // move the slider
            moveSlider(to: move, animated: false)
        default:
            break
        }
        
        gesture.setTranslation(.zero, in: slider)
    }
}

private extension SliderView {
    func moveSlider(to move: CGFloat, animated: Bool) {
        sliderConstraint.isActive = false
        sliderConstraint.constant = move
        sliderConstraint.isActive = true
        
        if animated {
            UIView.animate(
                withDuration: 0.2,
                delay: 0,
                options: .curveEaseIn,
                animations: { [weak self] in
                    self?.confirmLabel.alpha = move / (self?.frame.width ?? 1)
                    self?.layoutIfNeeded()
                }, completion: nil)
        } else {
            confirmLabel.alpha = move / (frame.width)
        }
    }
}
