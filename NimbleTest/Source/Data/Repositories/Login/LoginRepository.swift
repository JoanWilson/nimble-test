import Foundation
import KeychainSwift

public final class LoginRepository: LoginUseCase {
    public static var shared = LoginRepository()
    public var baseURL = URL(string: "https://survey-api.nimblehq.co")!
    
    private let session: HTTPSessionProtocol
    private let secureStorage = KeychainSwift()
    
    init(session: HTTPSessionProtocol) {
        self.session = session
    }
    
    func login(for login: LoginEmailRequest) async throws -> Result<LoginSuccess, LoginError> {
        let endpoint = APIEndpoint.token
        let url = endpoint.url(for: baseURL)
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-type")
        
        let postData = try JSONEncoder().encode(login)
        request.httpBody = postData
        
        let (data, response) = try await session.data(for: request)
        let result = try loginHandler(response: (data, response))
        return result
    }
    
    func login(for login: LoginRefreshRequest) async throws -> Result<LoginSuccess, LoginError> {
        let endpoint = APIEndpoint.token
        let url = endpoint.url(for: baseURL)
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-type")
        
        let postData = try JSONEncoder().encode(login)
        request.httpBody = postData
        
        let (data, response) = try await session.data(for: request)
        let result = try loginHandler(response: (data, response))
        return result
    }
    
    private func loginHandler(response: (data: Data, response: URLResponse)) throws -> Result<LoginSuccess, LoginError> {
        guard let httpResponse = response.response as? HTTPURLResponse else {
            throw LoginEnumError.noResponse
        }
        
        switch httpResponse.statusCode {
        case 200..<300:
            LocalRepository.shared.saveUserTokens(loginSuccess: response.data)
            let loginSuccess = try JSONDecoder().decode(LoginSuccess.self, from: response.data)
            return .success(loginSuccess)
        default:
            let loginError = try JSONDecoder().decode(LoginError.self, from: response.data)
            return .failure(loginError)
        }
    }
}

extension LoginRepository {
    
    @_disfavoredOverload
    public convenience init(session: URLSession = .shared) {
        self.init(session: session)
    }
}
