//
//  Appointment.swift
//  Vollmed
//
//  Created by Rafael Seron on 28/07/24.
//

import Foundation

struct Appointment: Identifiable, Codable{
    let id: String
    let appointmentDate: String
    let specialist: Specialist
    
    enum CodingKeys: String, CodingKey{
        case id = "id"
        case appointmentDate = "data"
        case specialist = "especialista"
    }
    
}
