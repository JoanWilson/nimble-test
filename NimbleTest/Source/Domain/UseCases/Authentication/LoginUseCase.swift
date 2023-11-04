import Foundation

protocol LoginUseCase {
    func login(for login: LoginEmailRequest) async throws -> Result<LoginSuccess, LoginError>
    func login(for login: LoginRefreshRequest) async throws -> Result<LoginSuccess, LoginError>
}
