import Foundation

enum APIEndpoint: String {
    case token = "/api/v1/oauth/token"
    case revoke = "/api/v1/oauth/revoke"
    case passwords = "/api/v1/passwords"
    case surveys = "/api/v1/surveys"
    case me = "/api/v1/me"
    
    public func url(for baseURL: URL) -> URL {
        return baseURL.appendingPathComponent(rawValue)
    }
}

extension APIEndpoint: CaseIterable {}
