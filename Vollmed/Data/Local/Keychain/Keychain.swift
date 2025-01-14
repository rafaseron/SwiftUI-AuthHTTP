//
//  Keychain.swift
//  Vollmed
//
//  Created by Rafael Seron on 12/01/25.
//
import Foundation

enum KeychainHelper {
    enum KeychainError: Error {
        case unableToSave
        case unableToDelete
        case unableToRead
    }

    enum KeychainReturnMessage: String {
        case saved
    }

    static func save(forKey key: String, value: String) -> Result<String, Error> {
        guard let data = value.data(using: .utf8) else { return Result.failure(KeychainError.unableToSave) }

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data,
        ]
        SecItemDelete(query as CFDictionary)
        let status = SecItemAdd(query as CFDictionary, nil)
        if status == errSecSuccess { return Result.failure(KeychainError.unableToSave) }
        return Result.success(KeychainReturnMessage.saved.rawValue)
    }

    static func remove(forKey key: String) -> Result<String, Error> {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
        ]
        let status = SecItemDelete(query as CFDictionary)
        return Result.success(KeychainReturnMessage.saved.rawValue)
    }

    static func read(forKey key: String) -> Result<String, Error> {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne,
        ]

        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)

        guard status == errSecSuccess, let data = item as? Data else { return Result.failure(KeychainError.unableToRead) }
        guard let data = String(data: data, encoding: .utf8) else { return Result.failure(KeychainError.unableToRead) }
        return Result.success(data)
    }
}
