import Foundation

struct LoginEmailRequest: Codable {
    let grantType, email, password, clientID: String
    let clientSecret: String
    
    init(grantType: String, email: String, password: String, clientID: String, clientSecret: String) {
        self.grantType = grantType
        self.email = email
        self.password = password
        self.clientID = clientID
        self.clientSecret = clientSecret
    }
    
    enum CodingKeys: String, CodingKey {
        case grantType = "grant_type"
        case email, password
        case clientID = "client_id"
        case clientSecret = "client_secret"
    }
}
