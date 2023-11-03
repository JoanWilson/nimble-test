import Foundation

struct LoginError: Codable {
    let errors: [LoginErrors]
}

struct LoginErrors: Codable {
    let source, detail, code: String?
}

