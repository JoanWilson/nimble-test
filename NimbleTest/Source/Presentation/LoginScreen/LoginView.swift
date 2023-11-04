import UIKit

public final class LoginView: UIView {
    
    private lazy var imageBackground: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Images/loginBackground")
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private lazy var logo: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Logos/logoWhite")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    internal lazy var loginTextField: UITextField = {
        let textField = TextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor(named: "Colors/FieldBackground")
        textField.layer.cornerRadius = 10
        textField.placeholder = "Email"
        textField.keyboardType = .emailAddress
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.font = .systemFont(ofSize: 17)
        
        return textField
    }()
    
    internal lazy var passwordTextField: UITextField = {
        let textField = TextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor(named: "Colors/FieldBackground")
        textField.layer.cornerRadius = 10
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.font = .systemFont(ofSize: 17)
 
        return textField
    }()
    
    internal lazy var logInButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.tintColor = .black
        button.setTitle("Log in", for: .normal)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        
        return button
    }()
    
    internal lazy var forgotButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.tintColor = .systemGray
        button.setTitle("Forgot?", for: .normal)
        
        return button
    }()
    
    
    public override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        buildLayout()
        tintColor = .white
    }
}

extension LoginView: ViewCoding {
    func setupHierarchy() {
        addSubview(imageBackground)
        addSubview(logo)
        addSubview(loginTextField)
        addSubview(passwordTextField)
        addSubview(logInButton)
        addSubview(forgotButton)
    }
    
    func setupConstraints() {
        imageBackgroundConstraints()
        logoConstraints()
        loginTextFieldConstraints()
        passwordTextFieldConstraints()
        logInButtonConstraints()
        forgotButtonConstraints()
    }
    
    private func imageBackgroundConstraints() {
        NSLayoutConstraint.activate([
            imageBackground.topAnchor.constraint(equalTo: topAnchor),
            imageBackground.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageBackground.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageBackground.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func logoConstraints() {
        NSLayoutConstraint.activate([
            logo.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.45),
            logo.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.05),
            logo.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,
                                      constant: UIScreen.main.bounds.height * 0.13),
            logo.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func loginTextFieldConstraints() {
        NSLayoutConstraint.activate([
            loginTextField.topAnchor.constraint(equalTo: logo.bottomAnchor,
                                                constant: UIScreen.main.bounds.height * 0.13),
            loginTextField.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.07),
            loginTextField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.9),
            loginTextField.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func passwordTextFieldConstraints() {
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor,
                                                constant: 20),
            passwordTextField.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.07),
            passwordTextField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.9),
            passwordTextField.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func logInButtonConstraints() {
        NSLayoutConstraint.activate([
            logInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor,
                                                constant: 20),
            logInButton.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.07),
            logInButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.9),
            logInButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func forgotButtonConstraints() {
        NSLayoutConstraint.activate([
            forgotButton.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),
            forgotButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor, constant: -17),
        ])
    }
}
