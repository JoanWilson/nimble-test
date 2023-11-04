import UIKit

public enum LoginFactory {
    static public func makeViewController() -> UIViewController {
        let viewModel: LoginViewModelProtocol = LoginViewModel()
        let viewController = LoginViewController(viewModel: viewModel)

        return viewController
    }
}

