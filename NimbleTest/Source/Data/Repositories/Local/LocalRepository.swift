import Foundation
import KeychainSwift

public final class LocalRepository {
    
    public static let shared = LocalRepository()
    private let secureStorage = KeychainSwift()
    
    private init() {}
    
    public func saveUserTokens(loginSuccess data: Data) {
        secureStorage.saveData(
            value: data,
            forKey: LoginEnumData.userTokens.rawValue
        )
    }
    
    public func getTokens() -> LoginSuccess? {
        guard let data = secureStorage.getData(LoginEnumData.userTokens.rawValue) else {
            print("Not Found in Keychain")
            return nil
        }
        
        do {
            let tokens = try JSONDecoder().decode(LoginSuccess.self, from: data)
            return tokens
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
