import UIKit

public final class LoginViewController: UIViewController {
    private let contentView = LoginView()
    private let viewModel: LoginViewModelProtocol
    
    init(viewModel: LoginViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    public override func loadView() {
        super.loadView()
        view = contentView
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyboardHiding()
        hideKeyboardWhenTappedAround()
        setupLoginButton()
    }
}

extension LoginViewController {
    private func setupLoginButton() {
        contentView.logInButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
    }
    
    @objc func didTapLoginButton(_ sender: Any) {
        Task {
            guard let email = contentView.loginTextField.text,
                  let password = contentView.passwordTextField.text else {
                print("Nulo")
                return
            }
            let result = await login(email: email, password: password)
            print(result)
        }
    }
    
    @objc func login(email: String, password: String) async -> Bool {
        let response = await viewModel.login(email: email, password: password)
        return response
    }
}

extension LoginViewController {
    private func setupKeyboardHiding() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        if view.frame.origin.y == 0 {
            view.frame.origin.y = view.frame.origin.y - 50
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
    }
}
