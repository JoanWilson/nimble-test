import Foundation

enum RepositoryError: Error {
    case noAccessToken
    case noRefreshToken
    case requestFailed
}
