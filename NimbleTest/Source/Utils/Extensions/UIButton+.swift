import UIKit

extension UIButton {
    
    func loadingIndicator(_ show: Bool) {
        let indicatorTag = 808404
        if show {
            isEnabled = false
            alpha = 0
            let indicator = UIActivityIndicatorView()
            indicator.color = .white
            indicator.center = center
            indicator.tag = indicatorTag
            superview?.addSubview(indicator)
            indicator.startAnimating()
        } else {
            isEnabled = true
            alpha = 1.0
            if let indicator = superview?.viewWithTag(indicatorTag) as? UIActivityIndicatorView {
                indicator.stopAnimating()
                indicator.removeFromSuperview()
            }
        }
    }
}
