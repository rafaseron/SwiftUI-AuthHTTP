//
//  Login.swift
//  Vollmed
//
//  Created by Rafael Seron on 09/12/24.
//

/// Login Request Model
/// 
/// - This model is used to send a login request to API
struct LoginRequest {
    let email: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case email
        case password = "senha"
    }
}

/// Login Response Model
/// 
/// - This model is used to receive a response from API login request
struct LoginResponse {
    let auth: Bool
    let id: String
    let token: String
}

extension LoginRequest: Encodable {
    
}

extension LoginResponse: Identifiable, Decodable {
    private enum CodingKeys: String, CodingKey {
        case auth
        case id
        case token
    }
}
