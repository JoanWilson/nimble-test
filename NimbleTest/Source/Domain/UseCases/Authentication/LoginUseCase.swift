import Foundation

protocol LoginUseCase {
    func login(for login: LoginRequest) async throws -> LoginSuccess
}
