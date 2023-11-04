import Foundation

protocol LoginUseCase {
    func login(for login: LoginRequest) async throws -> Result<LoginSuccess, LoginEnumError>
}
