//
//  Date+.swift
//  Vollmed
//
//  Created by Rafael Seron on 26/06/24.
//

import Foundation

// No console, usando Date em Swift, temos -> 2024-06-27 09:45:00 +0000
// Na API, precisamos chegar neste resultado -> 2024-06-15T10:36:00.000  ->  ou seja, da pra ver que não tem o fuso horário ai

                // conversão -> yyyy-mm-dd'T'hh:mm:ss:SSZ


extension Date{
    
    func toString() -> String{
        
        // Crar um objeto de DateFormatter() para conseguir definir o formato desejado
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        // Retornar uma instancia com a formatacao aplicada -> From 'Date' to 'String'
        return dateFormater.string(from: self)
    }
    
}
