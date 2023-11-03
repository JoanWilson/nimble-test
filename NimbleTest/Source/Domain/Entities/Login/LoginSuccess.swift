import Foundation

struct LoginSuccess: Codable {
    let data: LoginSuccessData
}

struct LoginSuccessData: Codable {
    let id, type: String?
    let attributes: Attributes?
}

struct Attributes: Codable {
    let accessToken, tokenType: String?
    let expiresIn: Int?
    let refreshToken: String?
    let createdAt: Int?

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case refreshToken = "refresh_token"
        case createdAt = "created_at"
    }
}
