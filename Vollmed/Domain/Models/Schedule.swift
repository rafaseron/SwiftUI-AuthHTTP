//
//  Schedule.swift
//  Vollmed
//
//  Created by Rafael Seron on 27/06/24.
//

import Foundation

// Model para fazer um POST de uma consulta
struct ScheduleRequest: Codable{
    let specialistID: String
    let patientID: String
    let date: String
    
    enum CodingKeys: String, CodingKey{
        case specialistID = "especialista"
        case patientID = "paciente"
        case date = "data"
    }
    
    
}

// Model para Receber um Response de um POST feito, fazer um GET, GET by ID, PATCH by ID e DELETE by ID de uma consulta, etc
struct ScheduleResponse: Codable, Identifiable{
    let id: String
    let specialistID: String
    let patientID: String
    let date: String
    let reasonToCancel: String?
    
    enum CodingKeys: String, CodingKey{
        case id = "id"
        case specialistID = "especialista"
        case patientID = "paciente"
        case date = "data"
        case reasonToCancel = "motivoCancelamento"
    }
    
    
}
