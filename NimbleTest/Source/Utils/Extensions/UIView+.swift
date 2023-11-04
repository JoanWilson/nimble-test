
import UIKit

extension UIView {
    func constraintToSuperView() {
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        
        topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
        leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
        rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true
    }
    
    func constraintToSelfView() {
        topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    func constraintToSafeArea() {
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        
        topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor).isActive = true
        leftAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leftAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor).isActive = true
        rightAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.rightAnchor).isActive = true
    }
    
    func addBlurToView(_ blurStyle: UIBlurEffect.Style) {
        var blurEffect: UIBlurEffect
        blurEffect = UIBlurEffect(style: blurStyle)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = self.bounds
        blurredEffectView.alpha = 1
        blurredEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurredEffectView)
    }
}
