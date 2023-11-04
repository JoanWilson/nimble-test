import Foundation

struct LoginRefreshRequest: Codable {
    let grantType, refreshToken, clientID, clientSecret: String

    enum CodingKeys: String, CodingKey {
        case grantType = "grant_type"
        case refreshToken = "refresh_token"
        case clientID = "client_id"
        case clientSecret = "client_secret"
    }
}
