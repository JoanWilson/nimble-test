import Foundation

public final class LoginRepository: LoginUseCase {
    
    public static var shared = LoginRepository()
    public var baseURL = URL(string: "https://survey-api.nimblehq.co")!
    
    private let session: HTTPSessionProtocol
    
    init(session: HTTPSessionProtocol) {
        self.session = session
    }
    
    func login(for login: LoginRequest) async throws -> LoginSuccess {
        let endpoint = LoginEndpoint.token
        let url = endpoint.url(for: baseURL)
        let postData: Data = try JSONSerialization.data(withJSONObject: login.dictionaryParameters, options: [])
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = postData
        
        let (data, response) = try await session.data(for: request)
        let result = try JSONDecoder().decode(LoginSuccess.self, from: mapLoginResponse(response: (data, response)))
        return result
    }
    
}

extension LoginRepository {
    
    @_disfavoredOverload
    public convenience init(session: URLSession = .shared) {
        self.init(session: session)
    }
}
