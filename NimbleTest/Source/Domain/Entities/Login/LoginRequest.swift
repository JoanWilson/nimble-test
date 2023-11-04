import Foundation

//struct LoginRequest {
//    let grantType: String
//    let email: String
//    let password: String
//
//    var dictionaryParameters: [String: Any] {
//        guard let clientId = Bundle.main.infoDictionary?["CLIENT_ID"] as? String,
//              let clientSecret = Bundle.main.infoDictionary?["CLIENT_SECRET"] as? String else {
//            return [:]
//        }
//
//        return [
//            "grant_type": "password",
//            "email": email,
//            "password": password,
//            "client_id": clientId,
//            "client_secret": clientSecret
//        ]
//    }
//}

struct LoginRequest: Codable {
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
