//
//  HomeView.swift
//  Vollmed
//
//  Created by Giovanna Moeller on 12/09/23.
//

import SwiftUI

struct HomeView: View {
    @State var especialistasList: [Specialist] = []
    @State var isNotAuthenticated: Bool = false

    let service = WebService()

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

                if especialistasList.isEmpty {
                    Spacer()
                        .frame(height: 25)

                    Text("Estamos com problemas no momento")

                    Spacer()
                        .frame(height: 25)

                    Image(systemName: "wifi.slash")
                        .font(.system(size: 50))

                } else {
                    ForEach(especialistasList) { specialist in
                        SpecialistCardView(specialist: specialist)
                            .padding(.bottom, 8)
                    }
                }
            }
            .padding(.horizontal)
        }
        .padding(.top)
        .onAppear {
            loginVerification()
            Task {
                await acessGetAllSpecialists()
            }
        }
        // Também da pra usar o modificador .task -> funciona igual o onAppear + Task
        .task {
            // code
        }
        .navigationTitle("Médicos")
        .navigationBarTitleDisplayMode(.large)
        .navigationBarBackButtonHidden()
        .navigationDestination(isPresented: $isNotAuthenticated) {
            LoginView()
        }
    }

    // MARK: - Métodos dentro de HomeView

    func acessGetAllSpecialists() async {
        do {
            let specialists = try await service.getAllSpecialists()

            guard let specialistas = specialists else {
                especialistasList = []
                return
            }

            especialistasList = specialistas

        } catch {
            especialistasList = []
        }
    }

    func loginVerification() {
        do {
            let _ = try UserDefaultsHelper.read(forKey: UserDefaultsKeys.jwtToken.rawValue)
            let _ = try UserDefaultsHelper.read(forKey: UserDefaultsKeys.userId.rawValue)
        } catch {
            isNotAuthenticated = true
        }
    }
}

#Preview {
    HomeView()
}
