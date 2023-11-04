import Foundation

enum LoginEndpoint: String {
    case token = "/api/v1/oauth/token"
    case revoke = "/api/v1/oauth/revoke"
    case passwords = "/api/v1/passwords"
    
    public func url(for baseURL: URL) -> URL {
        return baseURL.appendingPathComponent(rawValue)
    }
}

extension LoginEndpoint: CaseIterable {}
