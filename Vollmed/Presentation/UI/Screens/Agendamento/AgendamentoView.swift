//
//  AgendamentoView.swift
//  Vollmed
//
//  Created by Rafael Seron on 25/06/24.
//

import SwiftUI

struct AgendamentoView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel: AgendamentoViewModel

    init(isRescheduleView: Bool = false, specialist: Specialist, appointment: Appointment? = nil) {
        _viewModel = StateObject(wrappedValue: AgendamentoViewModel(isRescheduleView: isRescheduleView, specialist: specialist, appointment: appointment))
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 6.0) {
            Text("Selecione a data e horário da consulta")
                .font(.title3)
                .bold()
                .multilineTextAlignment(.center)
                .foregroundStyle(.accent)
                .padding(.top)
                .padding(.bottom, 10.0)

            // Conteúdo visual da RescheduleView -> Text com Data atual, atualizar o date do DatePicker com a Data atual
            if viewModel.isRescheduleView {
                if viewModel.appointment != nil {
                    if !viewModel.isAtualDateChanged {
                        Text("Sua data atual é: \(viewModel.appointment!.appointmentDate.toReadableDate())")
                            .bold()
                            .task {
                                viewModel.getDateOnRescheduleView()
                            }
                    } else {
                        Text("Sua data atual é: \(viewModel.newDate)")
                            .bold()
                            .task {
                                viewModel.getDateOnRescheduleView()
                            }
                    }
                }
            }

            DatePicker("Escolha a data da consulta", selection: $viewModel.date)
                .datePickerStyle(.graphical)

            Button(action: {
                Task {
                    if !viewModel.isRescheduleView {
                        await viewModel.postSchedule()
                    } else {
                        await viewModel.updateSchedule()
                        print("Rodar updateSchedule aqui")
                    }
                }

            }, label: {
                ButtonView(text: viewModel.isRescheduleView ? "Remarcar consulta" : "Agendar consulta")
            }).alert(viewModel.isRescheduleView ? "Remarcar consulta" : "Agendar consulta", isPresented: $viewModel.showAlert, presenting: {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Ok")
                })
            }, actions: { _ in
                // actions code
            }, message: { _ in
                if viewModel.scheduleResponse != nil {
                    Text(viewModel.scheduleResponse!)
                } else {
                    Text("Tivemos um problema")
                }
            }) // Este alert, diferente do anterior, você consegue definir como vai ser o botão, e ai pode adicionar códigos que
            // não são aceitos dentro de um Protocol 'View'.

            // Porém não funcionou o .dimiss(), então fica o código anterior abaixo:

            /*
             .alert("Agendamento de consultas", isPresented: $showAlert, actions: {
                 //actions code
             }, message: {
                 if scheduleResponse != nil{
                     Text(scheduleResponse!)
                 } else{
                     Text("Tivemos um problema")
                 }
             })*/
        }
        .padding(.all)
        .navigationTitle(viewModel.isRescheduleView ? "Remarcar" : "Agendar")
        .navigationBarTitleDisplayMode(.large)
        .onAppear {
            UIDatePicker.appearance().minuteInterval = 15
        }
    }
}

#Preview {
    AgendamentoView(specialist: Specialist(id: "String", name: "String", crm: "String", imageUrl: "String", specialty: "String", email: "String", phoneNumber: "String"))
}
