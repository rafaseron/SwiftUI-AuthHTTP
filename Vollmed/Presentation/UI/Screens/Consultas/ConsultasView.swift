//
//  ConsultasView.swift
//  Vollmed
//
//  Created by Rafael Seron on 02/07/24.
//

import SwiftUI

struct ConsultasView: View {
    @StateObject private var viewModel: ConsultasViewModel = .init()

    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(alignment: .center, spacing: 16.0) {
                if !viewModel.appointments.isEmpty {
                    ForEach(viewModel.appointments) { appointment in
                        SpecialistCardView(specialist: appointment.specialist,
                                           isAppointmentView: true, appointment: appointment)
                    }
                } else {
                    Image(systemName: "minus.circle")
                        .bold()
                        .font(.title)
                    Text("Sem consultas agendadas")
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .padding(.horizontal)
        }.onAppear {
            // code
        }
        .task {
            let _ = await viewModel.getAllAppointmentsForThisPatient()
        }
        .navigationTitle("Agendadas")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    ConsultasView()
}
