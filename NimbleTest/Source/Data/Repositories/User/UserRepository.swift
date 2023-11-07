import Foundation

public final class UserRepository: UserUseCase {
    public var baseURL = URL(string: "https://survey-api.nimblehq.co")!
    
    private let session: HTTPSessionProtocol
    
    init(session: HTTPSessionProtocol) {
        self.session = session
    }
    
    func loadUserData() async throws -> Result<User, RepositoryError> {
        let endpoint = APIEndpoint.me
        let url = endpoint.url(for: baseURL)
        var request = URLRequest(url: url)
        
        guard let tokens = LocalRepository.shared.getTokens() else {
            return .failure(.noAccessToken)
        }
        
        guard let accessToken = tokens.data.attributes?.accessToken else {
            return .failure(.noAccessToken)
        }
        
        request.httpMethod = "GET"
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await session.data(for: request)
        
        if response.statusCode > 200 {
            return .failure(.requestFailed)
        }
        
        let userData = try JSONDecoder().decode(User.self, from: data)
        
        print(userData)
        
        return .success(userData)
    }
}

extension UserRepository {
    
    @_disfavoredOverload
    public convenience init(session: URLSession = .shared) {
        self.init(session: session)
    }
}
