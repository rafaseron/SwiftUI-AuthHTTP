//
//  HomeView.swift
//  Vollmed
//
//  Created by Giovanna Moeller on 12/09/23.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel = .init()

    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack {
                Image(.logo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                    .padding(.vertical, 32)
                Text("Boas-vindas!")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(Color(.lightBlue))
                Text("Veja abaixo os especialistas da Vollmed disponíveis e marque já a sua consulta!")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.accent)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 16)

                if viewModel.especialistasList.isEmpty {
                    Spacer()
                        .frame(height: 25)

                    Text("Estamos com problemas no momento")

                    Spacer()
                        .frame(height: 25)

                    Image(systemName: "wifi.slash")
                        .font(.system(size: 50))

                } else {
                    ForEach(viewModel.especialistasList) { specialist in
                        SpecialistCardView(specialist: specialist)
                            .padding(.bottom, 8)
                    }
                }
            }
            .padding(.horizontal)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        // action
                    } label: {
                        HStack {
                            Image(systemName: "rectangle.portrait.and.arrow.forward")
                            Text("Logout")
                        }
                    }
                }
            }
        }
        .padding(.top)
        .onAppear {
            viewModel.loginVerification()
            Task {
                await viewModel.fetchSpecialists()
            }
        }
        // Também da pra usar o modificador .task -> funciona igual o onAppear + Task
        .task {
            // code
        }
        .navigationTitle("Médicos")
        .navigationBarTitleDisplayMode(.large)
        .navigationBarBackButtonHidden()
        .navigationDestination(isPresented: $viewModel.isNotAuthenticated) {
            LoginView()
        }
    }
}

#Preview {
    HomeView()
}
