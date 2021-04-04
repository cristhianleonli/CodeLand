import UIKit

extension Joystick {
    enum ArrowType {
        case top
        case down
        case left
        case right
    }
    
    func setupView() {
        backgroundColor = .clear
        
        addContainer()
        addStick()
        addArrows()
        addEvents()
    }
}

private extension Joystick {
    func addEvents() {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(panStick))
        stick.addGestureRecognizer(gesture)
    }
    
    @objc func panStick(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self)
        
        switch gesture.state {
        case .ended, .cancelled, .failed:
            moveSlider(x: 0, y: 0, animated: true)
        case .changed:
            let moveX: CGFloat = stickXConstraint.constant + translation.x
            let moveY: CGFloat = stickYConstraint.constant + translation.y
            
            if pointIsInside(CGPoint(x: moveX, y: moveY)) {
                moveSlider(x: moveX, y: moveY, animated: false)
            }
            
        default:
            break
        }
        
        gesture.setTranslation(.zero, in: stick)
    }
    
    func addStick() {
        addSubview(stick)
        stick.translatesAutoresizingMaskIntoConstraints = false
        stick.backgroundColor = mainColor
        
        stickYConstraint = stick.centerYAnchor.constraint(equalTo: centerYAnchor)
        stickXConstraint = stick.centerXAnchor.constraint(equalTo: centerXAnchor)
        
        NSLayoutConstraint.activate([
            stick.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            stick.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            stickXConstraint,
            stickYConstraint
            ])
    }
    
    func addContainer() {
        addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topAnchor),
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
    }
    
    func addArrows() {
        arrows = [
            addArrow(.top),
            addArrow(.down),
            addArrow(.right),
            addArrow(.left)
        ]
    }
    
    func moveSlider(x moveX: CGFloat, y moveY: CGFloat, animated: Bool) {
        stickXConstraint.isActive = false
        stickYConstraint.isActive = false
        
        stickXConstraint.constant = moveX
        stickYConstraint.constant = moveY
        
        stickXConstraint.isActive = true
        stickYConstraint.isActive = true
        
        if animated {
            UIView.animate(
                withDuration: 0.08,
                delay: 0,
                options: .curveEaseInOut,
                animations: { [weak self] in
                    self?.layoutIfNeeded()
                }, completion: nil)
        }
    }
    
    func pointIsInside(_ point: CGPoint) -> Bool {
        let ratio = Double(container.frame.width / 2) - Double(stick.frame.width / 2) + 5
        
        let hipo = pow(Double(abs(point.x)), 2) + pow(Double(abs(point.y)), 2)
        let distance = sqrt(hipo)
        
        return distance < ratio
    }
}
