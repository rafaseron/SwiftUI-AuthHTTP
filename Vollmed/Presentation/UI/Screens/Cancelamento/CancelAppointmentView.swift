//
//  CancelAppointmentView.swift
//  Vollmed
//
//  Created by Rafael Seron on 20/08/24.
//

import SwiftUI

struct CancelAppointmentView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel: CancelAppointmentViewModel

    init(appointmentId: String?) {
        _viewModel = StateObject(wrappedValue: CancelAppointmentViewModel(appointmentId: appointmentId))
    }

    var body: some View {
        LazyVStack(spacing: 8) {
            Text("Qual seria o motivo do cancelamento?")
                .font(.title3)
                .bold()
                .foregroundStyle(.accent)
                .padding(.top)

            Text("cancelamentos são permitidos somente com antecedência mínima de 1 dia")
                .font(.title3)
                .bold()
                .foregroundStyle(.cancel)
                .padding(.bottom)

            TextEditor(text: $viewModel.newTextValue)
                .padding()
                .font(.title3)
                .foregroundStyle(.accent)
                .scrollContentBackground(.hidden)
                .background(Color(.secondarySystemBackground))
                .frame(minHeight: 200, maxHeight: 300)
                .clipShape(.buttonBorder)
                .padding(.horizontal)

            Button(action: {
                Task {
                    await viewModel.onDeleteClick()
                }

            }, label: {
                ButtonView(text: "Cancelar consulta", buttonType: .cancel)
                    .padding(.horizontal)
            }).alert("Cancelamento", isPresented: $viewModel.isShowAlert, presenting: {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("OK")
                })
            }, actions: { _ in
                Text("OK")

            }, message: { _ in
                Text(viewModel.responseMessage)
            })

        }.navigationTitle("Cancelar")
            .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    CancelAppointmentView(appointmentId: "")
}
