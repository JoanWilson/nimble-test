import XCTest
@testable import NimbleTest

final class LoginRepositoryTests: XCTestCase {
    let sut = LoginRepository(session: .mock)
    
    func test_GivenLoginIsCorrect_WhenTheUserSendTheCorrectParameters_ShouldReturnLoginSuccessMessage() async throws {
        let request = LoginRequest(grantType: "password", email: "wilsonapitests@gmail.com", password: "12345678")
        let response = try await sut.login(for: request)
        XCTAssertEqual(response.data.attributes?.accessToken, "mockToken")
    }
}
