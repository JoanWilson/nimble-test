import UIKit

public final class LoginViewController: UIViewController {
    private let contentView = LoginView()
    private let viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
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
        addBinders()
    }
    
    private func addBinders() {
        addAuthenticationBinder()
        addErrorMessageBinder()
    }
    
    private func addAuthenticationBinder() {
        viewModel.$authenticationSuccess.sink { isLogged in
            if isLogged {
                DispatchQueue.main.async {
                    self.navigateToSurveyList()
                }
            }
        }.store(in: &viewModel.cancellable)
    }
    
    private func addErrorMessageBinder() {
        viewModel.$errorMessage.sink { message in
            if let message = message {
                DispatchQueue.main.async {
                    self.showErrorMessageAlert(message)
                }
            }
        }.store(in: &viewModel.cancellable)
    }
    
    private func navigateToSurveyList() {
        let surveyListViewController = SurveyFactory.makeViewController()
        navigationController?.pushViewController(surveyListViewController,
                                                 animated: true)
    }
    
    private func showErrorMessageAlert(_ message: String) {
        contentView.logInButton.loadingIndicator(false)
        let alert = UIAlertController(title: "Login Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension LoginViewController {
    private func setupLoginButton() {
        contentView.logInButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
    }
    
    @objc func didTapLoginButton(_ sender: Any) {
        contentView.logInButton.loadingIndicator(true)
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
