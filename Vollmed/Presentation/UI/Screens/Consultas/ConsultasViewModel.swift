//
//  ConsultasViewModel.swift
//  Vollmed
//
//  Created by Rafael Seron on 23/12/24.
//
import Foundation

class ConsultasViewModel: ObservableObject {
    @Published var appointments: [Appointment] = []

    func getAllAppointmentsForThisPatient() async -> Result<Void, Error> {
        do {
            guard let appointmentList = try await WebService.shared.getAppointmentsByPatientId(idPaciente: WebService.patientId) else {
                return Result.failure(RequestError.emptyResponse)
            }
            appointments = appointmentList
            return Result.success(())
        } catch {
            return Result.failure(error)
        }
    }
}
