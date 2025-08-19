//
//  KeychainManager.swift
//  LogMe
//
//  Created by Arviejhay Alejandro on 8/19/25.
//

import Foundation
import CryptoKit

class KeychainManager {
    static let shared = KeychainManager()
    private let service = "com.logme.keychain"
    
    private func key(for username: String) -> SymmetricKey {
        let keyData = SHA256.hash(data: Data(username.utf8))
        return SymmetricKey(data: keyData)
    }
    
    func save(username: String, password: String) throws {
        let key = key(for: username)
        let passwordData = Data(password.utf8)
        let sealedBox = try AES.GCM.seal(passwordData, using: key)
        let combined = sealedBox.combined!
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: username,
            kSecValueData as String: combined
        ]
        SecItemDelete(query as CFDictionary)
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else {
            throw SignUpError.registrationFailed
        }
    }
    
    func getPassword(username: String) throws -> String? {
        let key = key(for: username)
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: username,
            kSecReturnData as String: true
        ]
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        guard status == errSecSuccess, let data = item as? Data else {
            return nil
        }
        let sealedBox = try AES.GCM.SealedBox(combined: data)
        let decrypted = try AES.GCM.open(sealedBox, using: key)
        return String(data: decrypted, encoding: .utf8)
    }
}
