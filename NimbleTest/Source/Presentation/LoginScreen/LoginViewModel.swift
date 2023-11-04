import Foundation
import Combine

protocol LoginViewModelProtocol: ObservableObject {
    var authenticationSuccess: Bool { get }
    var errorMessage: String? { get }
    func login(email: String, password: String) async -> Bool
}

public final class LoginViewModel: LoginViewModelProtocol {
    @Published internal var authenticationSuccess: Bool = false
    @Published internal var errorMessage: String? = nil
    
    internal var cancellable: Set<AnyCancellable> = []
    
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
        let loginRequest = LoginEmailRequest(grantType: "password",
                                        email: email,
                                        password: password, 
                                        clientID: clientId,
                                        clientSecret: clientSecret)
        
        do {
            let result = try await useCase.login(for: loginRequest)
            switch result {
            case .success(let success):
                authenticationSuccess = true
                print(success)
                return true
            case .failure(let error):
                print(error.errors.first?.detail ?? "Unknown error")
                authenticationSuccess = false
                errorMessage = error.errors.first?.detail
                return false
            }
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
}
