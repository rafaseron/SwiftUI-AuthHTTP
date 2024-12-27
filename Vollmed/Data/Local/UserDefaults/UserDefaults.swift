//
//  UserDefaults.swift
//  Vollmed
//
//  Created by Rafael Seron on 11/12/24.
//

import Foundation

enum UserDefaultsKeys: String {
    case jwtToken
    case userId
}

/// A Helper to use UserDefaults without instance that
enum UserDefaultsHelper {
    enum UserDefaultsError: Error {
        case valueNotFound
    }

    /// Generic function to read a value from a key in UserDefaults.
    ///
    /// - Parameter forKey: is the key that will be used to access the UserDefaults
    /// - Returns String: with the value of the specific key
    /// - Throws: if the value does not exist for this key
    static func read(forKey key: String) throws -> String {
        guard let result = UserDefaults.standard.string(forKey: key) else {
            throw UserDefaultsError.valueNotFound
        }
        return result
    }

    /// Generic function to save a value in a key in UserDefaults.
    ///
    /// - Parameter forKey: is the key that will be used to access the UserDefaults
    /// - Parameter value: is the value that will be saved in the key
    static func save(forKey key: String, value: String) {
        UserDefaults.standard.set(value, forKey: key)
    }

    /// Generic function to remove a value from a key in UserDefaults.
    ///
    /// - Parameter forKey: is the key that will be removed from UserDefaults. Its value is also removed.
    static func remove(forKey key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
