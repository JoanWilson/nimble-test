import Foundation

protocol UserUseCase {
    func loadUserData() async throws -> Result<User, RepositoryError>
}
