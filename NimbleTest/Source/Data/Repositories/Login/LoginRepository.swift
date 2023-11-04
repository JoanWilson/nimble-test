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
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-type")
        
        let postData = try! JSONEncoder().encode(login)

        request.httpBody = postData
        print(postData)
        
        let (data, response) = try await session.data(for: request)
        
        if response.statusCode > 300 {
            let result = try JSONDecoder().decode(LoginError.self, from: data)
            let result2 = try JSONDecoder().decode(LoginSuccess.self, from: mapLoginResponse(response: (data, response)))
            
            print(result)
            return result2
        } else {
            let result = try JSONDecoder().decode(LoginSuccess.self, from: mapLoginResponse(response: (data, response)))
            
            return result
        }
        
        //
        //        let result = try JSONDecoder().decode(LoginSuccess.self, from: mapLoginResponse(response: (data, response)))
        //
        //        eturn result
    }
    
}

extension LoginRepository {
    
    @_disfavoredOverload
    public convenience init(session: URLSession = .shared) {
        self.init(session: session)
    }
}
