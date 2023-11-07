import Foundation

struct LoginError: Codable, Error {
    let errors: [LoginErrors]
}

struct LoginErrors: Codable {
    let source, detail, code: String?
}

