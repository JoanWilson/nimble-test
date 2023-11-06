import Foundation
import KeychainSwift

enum SurveyEnumError: Error {
    case noAccessToken
    case noRefreshToken
    case requestFailed
}

public final class SurveyRepository {
    public var baseURL = URL(string: "https://survey-api.nimblehq.co")!
    
    private let session: HTTPSessionProtocol
    
    init(session: HTTPSessionProtocol) {
        self.session = session
    }
    
    func loadSurveys() async throws -> Result<SurveyData, SurveyEnumError> {
        let endpoint = APIEndpoint.surveys
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
        
        let surveyData = try JSONDecoder().decode(SurveyData.self, from: data)
        return .success(surveyData)
    }
}

extension SurveyRepository {
    
    @_disfavoredOverload
    public convenience init(session: URLSession = .shared) {
        self.init(session: session)
    }
}
