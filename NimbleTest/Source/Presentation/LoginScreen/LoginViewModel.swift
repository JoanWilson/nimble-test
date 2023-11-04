import Foundation

protocol LoginViewModelProtocol: AnyObject {
    func login(email: String, password: String) async -> Bool
}

public final class LoginViewModel {
    private let useCase: LoginUseCase
    
    init(useCase: LoginUseCase) {
        self.useCase = useCase
    }
    
    func login(email: String, password: String) async -> Bool {
        guard let clientId = Bundle.main.infoDictionary?["CLIENT_ID"] as? String,
              let clientSecret = Bundle.main.infoDictionary?["CLIENT_SECRET"] as? String else {
            print("Error while getting api keys")
            return false
        }
        let loginRequest = LoginRequest(grantType: "password",
                                        email: email,
                                        password: password, 
                                        clientID: clientId,
                                        clientSecret: clientSecret)
        
        do {
            let result = try await useCase.login(for: loginRequest)
            switch result {
            case .success(let success):
                print(success)
                return true
            case .failure(let error):
                print(error.errors.first?.detail ?? "Unknown error")
                return false
            }
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
}

extension LoginViewModel: LoginViewModelProtocol {
    
}
