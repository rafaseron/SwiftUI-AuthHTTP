//
//  AgendamentoViewModel.swift
//  Vollmed
//
//  Created by Rafael Seron on 20/12/24.
//
import Foundation

class AgendamentoViewModel: ObservableObject {
    @Published var isRescheduleView: Bool = false
    @Published var scheduleResponse: String? = nil
    @Published var showAlert: Bool = false
    @Published var date: Date = .init()
    @Published var isAtualDateChanged: Bool = false
    @Published var newDate: String = ""

    let specialist: Specialist
    let appointment: Appointment?

    init(isRescheduleView: Bool, specialist: Specialist, appointment: Appointment?) {
        self.isRescheduleView = isRescheduleView
        self.specialist = specialist
        self.appointment = appointment
    }

    func postSchedule() async {
        do {
            // Tentando realizar o Post e já desenbrulhando a 'ScheduleResponse' que receberemos do 'postAppointment'
            guard let response = try await WebService.shared.postAppointment(specialistId: specialist.id, patientId: WebService.patientId, date: date.toString()) else {
                scheduleResponse = nil
                return
            }

            // Receber a Data agendada no 'scheduleResponse'. Transformar em Data Legível ao Usuario.
            scheduleResponse = "Consulta agendada para: \(response.date.toReadableDate())"
            showAlert = true

        } catch {
            scheduleResponse = "Oops! ... Considere agendar com um profissional que você não tenha consultas no mesmo dia e das 7h as 19h. Se os problemas persistirem, por favor entre em contato."
            showAlert = true
        }
    }

    func getDateOnRescheduleView() {
        guard let receivedDate = appointment!.appointmentDate.toDate() else {
            return
        }
        date = receivedDate
    }

    func updateSchedule() async {
        do {
            if appointment != nil {
                guard let updateScheduleResponse = try await WebService.shared.updateAppointment(newDate: date.toString(), appointmentId: appointment!.id) else {
                    return
                }

                scheduleResponse = "Sua consulta foi remarcada com sucesso"
                isAtualDateChanged = true
                newDate = updateScheduleResponse.date.toReadableDate()
                showAlert = true
            }

        } catch {
            print(error)
            scheduleResponse = "Oops! ocorreu um erro ao remarcar a consulta. Se atente ao horário do consultório e tente novamente"
            showAlert = true
        }
    }
}
