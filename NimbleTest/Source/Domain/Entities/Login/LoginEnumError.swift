import Foundation

enum LoginEnumError: String, Error {
    case invalidGrant = "Invalid Grant"
    case invalidClient = "Invalid Client"
    case invalidEmailOrPassword = "Invalid Email or Password"
}
