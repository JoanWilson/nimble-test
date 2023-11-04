import Foundation

struct LoginRequest {
    let grantType: String
    let email: String
    let password: String
    
    var dictionaryParameters: [String: Any] {
        guard let clientId = Bundle.main.infoDictionary?["CLIENT_ID"] as? String,
              let clientSecret = Bundle.main.infoDictionary?["CLIENT_Secret"] as? String else {
            return [:]
        }
        
        return [
            "grant_type": "password",
            "email": email,
            "password": password,
            "client_id": clientId,
            "client_secret": clientSecret
        ]
    }
}
