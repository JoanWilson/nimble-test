@testable import NimbleTest
import Foundation

class MockSession: HTTPSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, HTTPURLResponse) {
        let url = request.url!
        switch url.lastPathComponent {
            case "token":
            let tokenFileURL = Bundle(for: type(of: self)).url(forResource: "token", withExtension: "json")!
                let data = try! Data(contentsOf: tokenFileURL)
                let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: "HTTP/2.0", headerFields: nil)!
                return (data, response)
            default:
                throw MockError.notImplemented(url: url)
        }
    }
    
    
    enum MockError: Error {
        case notImplemented(url: URL)
    }
}

extension HTTPSessionProtocol where Self == MockSession {
    static var mock: MockSession { .init() }
}
