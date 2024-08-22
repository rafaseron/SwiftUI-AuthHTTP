//
//  String+.swift
//  Vollmed
//
//  Created by Rafael Seron on 26/06/24.
//

import Foundation

extension String{
    
    func toReadableDate() -> String {
        
        // Como estamos recebendo uma Date já convertida em String, temos que converter de volta em Date
        let firstDateFormatter = DateFormatter()
        firstDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        guard let stringToDate = firstDateFormatter.date(from: self) else{
            return ""
        }
        
        // Agora, só transformar essa nova 'Date' em um formato que vc quer, e retornar
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy 'as' HH:mm"
        
        return dateFormatter.string(from: stringToDate)
    }
    
    // TODO -> verificar se a conversao está dando certo
    
     func toDate() -> Date? {
        // acesso ao self (data) e acesso ao Self (type)
        // Resposta atual em String -> 2024-07-02T14:36:00.000Z
     
         let dateFormatter = DateFormatter()
                 dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                 dateFormatter.locale = Locale(identifier: "pt_BR") // Define a localidade para evitar problemas de formatação
                 return dateFormatter.date(from: self)
     
     }
    
     
    
}
