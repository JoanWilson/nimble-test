import UIKit

public enum LoginFactory {
    static public func makeViewController() -> UIViewController {
        let useCase: LoginUseCase = LoginRepository(session: .shared)
        let viewModel: LoginViewModel = LoginViewModel(useCase: useCase)
        let viewController = LoginViewController(viewModel: viewModel)

        return viewController
    }
}
