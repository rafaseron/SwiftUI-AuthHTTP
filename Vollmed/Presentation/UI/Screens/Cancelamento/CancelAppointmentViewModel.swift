//
//  CancelAppointmentViewModel.swift
//  Vollmed
//
//  Created by Rafael Seron on 27/12/24.
//

import Foundation

class CancelAppointmentViewModel: ObservableObject {
    var appointmentId: String?
    @Published var newTextValue: String = ""
    @Published var isShowAlert: Bool = false
    @Published var responseMessage: String = "A consulta deve ser desmarcada com 1 dia de antecedência"

    init(appointmentId: String? = nil) {
        self.appointmentId = appointmentId
    }

    func onDeleteClick() async {
        guard let Id = appointmentId else {
            return
        }
        do {
            let deleteResponse = try await WebService.shared.deleteAppointment(appointmentId: Id, cancelReason: newTextValue)

            if deleteResponse {
                responseMessage = "Pedido de cancelamento enviado"
                isShowAlert = true
            }

            isShowAlert = true

        } catch {
            print(error)
            responseMessage = "Erro ao tentar cancelar"
            isShowAlert = true
        }
    }
}
