import UIKit

typealias ActionHandler = () -> Void

class Alert: UIView {
    
    // MARK: - Outlets
    
    @IBOutlet private var container: UIView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var subtitleLabel: UILabel!
    @IBOutlet private var primaryButton: UIButton!
    @IBOutlet private var secondaryButton: UIButton!
    
    @IBOutlet private var widthConstraintLayout: NSLayoutConstraint!
    @IBOutlet private var heightConstraintLayout: NSLayoutConstraint!
    
    // MARK: - Actions
    
    var onPrimaryTapped: ActionHandler = {}
    var onSecondaryTapped: ActionHandler = {}
    var onTapOutside: ActionHandler = {}
    var onAutoClose: ActionHandler = {}
    
    // MARK: - Properties
    
    var model: AlertModel? {
        didSet {
            updateUI()
        }
    }
    
    // MARK: - Life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        setupObservers()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.primaryButton.layer.cornerRadius = self.primaryButton.frame.height / 2
        self.secondaryButton.layer.cornerRadius = self.secondaryButton.frame.height / 2
    }
}

// MARK: - Move to a respective file in the project

private extension Alert {
    struct Colors {
        static let title = UIColor(red: 70/255, green: 82/255, blue: 87/255, alpha: 1)
        static let primary = UIColor(red: 59/255, green: 130/255, blue: 247/255, alpha: 1)
    }
}

private extension Alert {
    func updateUI() {
        titleLabel.text = model?.title
        subtitleLabel.text = model?.message
        primaryButton.setTitle(model?.primaryButton, for: .normal)
        secondaryButton.setTitle(model?.secondaryButton, for: .normal)
        
        if model?.primaryButton == nil {
            primaryButton.removeFromSuperview()
        }
        
        if model?.secondaryButton == nil {
            secondaryButton.removeFromSuperview()
        }
    }
    
    func setupUI() {
        backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        container.backgroundColor = .white
        
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowOpacity = 0.1
        container.layer.shadowOffset = .zero
        container.layer.shadowRadius = 10
        container.layer.cornerRadius = 10
        
        titleLabel.textColor = Colors.title
        subtitleLabel.textColor = Colors.title
        secondaryButton.setTitleColor(Colors.title, for: .normal)
        primaryButton.setTitleColor(.white, for: .normal)
        
        primaryButton.backgroundColor = Colors.primary
        secondaryButton.backgroundColor = .clear
    }
    
    func setupObservers() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapped))
        addGestureRecognizer(gesture)
    }
    
    @objc func tapped(_ sender: UITapGestureRecognizer) {
        if model?.isDismissable ?? false {
            self.onTapOutside()
            self.popOut()
        }
    }
    
    @IBAction func primaryButtonTapped(_ sender: Any) {
        onPrimaryTapped()
        popOut()
    }
    
    @IBAction func secondaryButtonTapped(_ sender: Any) {
        onSecondaryTapped()
        popOut()
    }
    
    func triggerAutoClose() {
        guard let duration = model?.autoCloseDuration else {
            return
        }
        
        switch duration {
        case .quick:
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
                self?.onAutoClose()
                self?.popOut()
            }
        case .long:
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) { [weak self] in
                self?.onAutoClose()
                self?.popOut()
            }
        case .none:
            break
        }
    }
}

extension Alert {
    static func instanceFromNib() -> Alert {
        return UINib(nibName: "Alert", bundle: nil)
            .instantiate(withOwner: nil, options: nil)[0] as! Alert
    }
    
    func show(in parent: UIView) {
        parent.addSubview(self)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: parent.topAnchor),
            self.bottomAnchor.constraint(equalTo: parent.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: parent.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: parent.trailingAnchor)
        ])
        
        popIn()
    }
    
    func popIn() {
        alpha = 0
        self.widthConstraintLayout.constant = self.containerWidth
        self.heightConstraintLayout.constant = self.containerHeight
        
        container.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.container.transform = .identity
            self.alpha = 1
        }) { _ in
            self.triggerAutoClose()
        }
    }
    
    func popOut() {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
            self.container.transform = CGAffineTransform.identity.scaledBy(x: 0.1, y: 0.1)
            self.alpha = 0
        }) { _ in
            self.removeFromSuperview()
        }
    }
    
    var containerWidth: CGFloat {
        return UIScreen.main.bounds.size.width * 0.9
    }
    
    var containerHeight: CGFloat {
        return UIScreen.main.bounds.size.width * 0.6
    }
}
