import Foundation

struct User: Codable {
    let data: UserData
}

struct UserData: Codable {
    let id, type: String
    let attributes: UserAttributes
}

struct UserAttributes: Codable {
    let email, name: String
    let avatarURL: String

    enum CodingKeys: String, CodingKey {
        case email, name
        case avatarURL = "avatar_url"
    }
}
