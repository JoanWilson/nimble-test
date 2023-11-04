import UIKit

public final class LoginViewController: UIViewController {
    private let contentView = LoginView()
    
    public override func loadView() {
        super.loadView()
        view = contentView
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
//        setupKeyboardHiding()
    }
    
    private func setupKeyboardHiding() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

extension LoginViewController {
    @objc func keyboardWillShow(sender: NSNotification) {
        if view.frame.origin.y == 0 {
            view.frame.origin.y = view.frame.origin.y - 50
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
    }
}
