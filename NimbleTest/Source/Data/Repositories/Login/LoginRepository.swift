import Foundation

public final class LoginRepository: LoginUseCase {
    
    public static var shared = LoginRepository()
    public var baseURL = URL(string: "https://survey-api.nimblehq.co")!
    
    private let session: HTTPSessionProtocol
    
    init(session: HTTPSessionProtocol) {
        self.session = session
    }
    
    func login(for login: LoginRequest) async throws -> Result<LoginSuccess, LoginEnumError> {
        let endpoint = LoginEndpoint.token
        let url = endpoint.url(for: baseURL)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
    }
}

extension LoginRepository {
    
    @_disfavoredOverload
    public convenience init(session: URLSession = .shared) {
        self.init(session: session)
    }
}
