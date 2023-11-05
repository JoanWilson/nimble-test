import Foundation
import KeychainSwift

public final class SurveyRepository: SurveyUseCase {
    public var baseURL = URL(string: "https://survey-api.nimblehq.co")!
    
    private let session: HTTPSessionProtocol
    
    init(session: HTTPSessionProtocol) {
        self.session = session
    }
    
    func loadSurveys() async throws -> SurveyData? {
        let endpoint = APIEndpoint.surveys
        let url = endpoint.url(for: baseURL)
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.addValue("", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await session.data(for: request)
        
        if response.statusCode == 200 {
            print("Error")
            let loginRepository = LoginRepository(session: .shared)
            let refreshToken = loginRepository.getTokens()
            
            
            return nil
        }
        
        let surveyData = try JSONDecoder().decode(SurveyData.self, from: data)
        return surveyData
    }
}

extension SurveyRepository {
    
    @_disfavoredOverload
    public convenience init(session: URLSession = .shared) {
        self.init(session: session)
    }
}
