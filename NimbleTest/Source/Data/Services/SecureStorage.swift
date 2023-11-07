import KeychainSwift

protocol SecureStorage {
    func saveData(value: Data, forKey: String)
    func getData(forKey: String) -> Data?
    func removeValue(forKey: String)
}

extension KeychainSwift: SecureStorage {
    
    func saveData(value: Data, forKey: String) {
        self.set(value, forKey: forKey)
    }
    
    func getData(forKey: String) -> Data? {
        return self.getData(forKey)
    }
    
    func removeValue(forKey: String) {
        self.delete(forKey)
    }
}
