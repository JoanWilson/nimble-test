import Foundation

struct LoginRequest: Codable {
    let grantType: String
    let email: String
    let password: String
    let clientID: String
    let clientSecret: String
    
    enum CodingKeys: String, CodingKey {
        case grantType = "grant_type"
        case email
        case password
        case clientID = "client_id"
        case clientSecret = "client_secret"
    }
}
