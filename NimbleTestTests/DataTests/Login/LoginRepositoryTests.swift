import XCTest
@testable import NimbleTest

final class LoginRepositoryTests: XCTestCase {
    let sut = LoginRepository(session: .mock)
    
    func test_GivenLoginIsCorrect_WhenTheUserSendTheCorrectParameters_ShouldReturnLoginSuccessMessage() async throws {
        let request = LoginEmailRequest(grantType: "password", email: "wilsonapitests@gmail.com", password: "12345678", clientID: "", clientSecret: "")
        let response = try await sut.login(for: request)
        switch response {
        case .success(let success):
            XCTAssertEqual(success.data.attributes?.accessToken, "mockToken")
        default:
            XCTAssert(false)
        }
    }
}
