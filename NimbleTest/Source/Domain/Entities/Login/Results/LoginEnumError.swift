import Foundation

public enum LoginEnumError: Error, LocalizedError {
    case invalidGrant
    case invalidClient
    case invalidEmailOrPassword
    case noResponse
    case http(httpResponse: HTTPURLResponse, data: Data)
}
