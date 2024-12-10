//
//  Login.swift
//  Vollmed
//
//  Created by Rafael Seron on 09/12/24.
//

struct LoginRequest {
    let email: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case email
        case password = "senha"
    }
}

struct LoginResponse {
    let auth: Bool
    let id: String
    let token: String
}

extension LoginRequest: Encodable {
    
}

extension LoginResponse: Decodable {
    private enum CodingKeys: String, CodingKey {
        case auth
        case id
        case token
    }
}
