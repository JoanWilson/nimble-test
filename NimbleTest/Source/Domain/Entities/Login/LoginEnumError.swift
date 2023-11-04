import Foundation

public enum LoginEnumError: Error, LocalizedError {
    case invalidGrant
    case invalidClient
    case invalidEmailOrPassword
    case http(httpResponse: HTTPURLResponse, data: Data)
}

func mapLoginResponse(response: (data: Data, response: URLResponse)) throws -> Data {
    guard let httpResponse = response.response as? HTTPURLResponse else {
        return response.data
    }
    
    switch httpResponse.statusCode {
    case 200..<300:
        return response.data
    case 400:
        throw LoginEnumError.invalidEmailOrPassword
    case 403:
        throw LoginEnumError.invalidClient
    default:
        throw LoginEnumError.http(httpResponse: httpResponse, data: response.data)
    }
}
