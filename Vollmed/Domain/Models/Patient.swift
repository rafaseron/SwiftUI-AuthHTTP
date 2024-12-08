//
//  Patient.swift
//  Vollmed
//
//  Created by Rafael Seron on 04/12/24.
//

/// This Struct represents a Patient in our application.
/// 
/// - id: optional, because when we are registering a patient, the id does not exist yet. But when we are receiving a patient from the API, the id already exists.
/// - cpf: CPF of the patient.
/// - name: name of the patient.
/// - email: email of the patient.
/// - password: password of the patient.
/// - phone: phone of the patient.
/// - healthPlan: health plan of the patient.
struct Patient: Codable, Identifiable {
    let id: String?
    let cpf: String
    let name: String
    let email: String
    let password: String
    let phone: String
    let healthPlan: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case cpf = "cpf"
        case name = "nome"
        case email = "email"
        case password = "senha"
        case phone = "telefone"
        case healthPlan = "planoSaude"
    }
}
