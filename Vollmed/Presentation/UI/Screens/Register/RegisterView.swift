//
//  RegisterView.swift
//  Vollmed
//
//  Created by Rafael Seron on 26/08/24.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel: RegisterViewModel = .init()

    var body: some View {
        ScrollView {
            Spacer()
                .frame(height: 50)
            VStack(spacing: 16) {
                Image(.logo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                    .padding(.top)

                Text("Olá, boas vindas!")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top)
                    .bold()
                    .foregroundStyle(.accent)
                    .font(.title2)

                Text("Insira seus dados para criar uma conta.")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)

                Text("Nome")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top)
                    .bold()
                    .foregroundStyle(.accent)
                    .font(.title3)

                TextField("Digite seu nome", text: $viewModel.name)
                    .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)
                    .padding(Edge.Set.horizontal, 16)
                    .background(Color.secondary.opacity(0.1))
                    .lineLimit(0)
                    .cornerRadius(14)

                Text("Telefone")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top)
                    .bold()
                    .foregroundStyle(.accent)
                    .font(.title3)

                TextField("Digite seu telefone", text: $viewModel.phoneNumber)
                    .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)
                    .padding(Edge.Set.horizontal, 16)
                    .background(Color.secondary.opacity(0.1))
                    .lineLimit(0)
                    .keyboardType(.numberPad)
                    .cornerRadius(14)

                Text("CPF")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top)
                    .bold()
                    .foregroundStyle(.accent)
                    .font(.title3)

                TextField("Digite seu CPF", text: $viewModel.cpf)
                    .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)
                    .padding(Edge.Set.horizontal, 16)
                    .background(Color.secondary.opacity(0.1))
                    .lineLimit(0)
                    .cornerRadius(14)
                    .keyboardType(.numberPad)

                Text("Email")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top)
                    .bold()
                    .foregroundStyle(.accent)
                    .font(.title3)

                TextField(
                    "Digite seu email",
                    text: $viewModel.email
                )
                .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)
                .padding(Edge.Set.horizontal, 16)
                .background(Color.secondary.opacity(0.1))
                .lineLimit(0)
                .cornerRadius(14)
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)

                Text("Password")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top)
                    .bold()
                    .foregroundStyle(.accent)
                    .font(.title3)

                SecureField("Digite sua senha", text: $viewModel.password)
                    .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)
                    .padding(Edge.Set.horizontal, 16)
                    .background(Color.secondary.opacity(0.1))
                    .lineLimit(0)
                    .cornerRadius(14)
                    .textInputAutocapitalization(.never)

                HStack {
                    Text("Plano de Saúde")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.top)
                        .bold()
                        .foregroundStyle(.accent)
                        .font(.title3)

                    Picker("Selecione seu plano de saúde", selection: $viewModel.selectedPlan) {
                        ForEach(healPlanList, id: \.self) { plan in
                            Text(plan)
                        }
                    }
                }

                Button {
                    let result = viewModel.validateFields()
                    if !result {
                        viewModel.alertMessage = "Preencha todos os campos"
                        viewModel.showAlert = true
                        return
                    }
                    if viewModel.selectedPlan == "" {
                        viewModel.alertMessage = "Você deve selecionar um Plano de Saúde"
                        viewModel.showAlert = true
                        return
                    }
                    Task {
                        await viewModel.registerPatient()
                    }

                } label: {
                    ButtonView(text: "Cadastrar")
                }.alert(viewModel.alertMessage, isPresented: $viewModel.showAlert) {
                    Button("Ok", role: .cancel) {}
                }

                NavigationLink {
                    LoginView()
                        .navigationBarBackButtonHidden()
                } label: {
                    Text("Já tenho uma conta")
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.accent)
                        .bold()
                }
            }
            .frame(maxWidth: .infinity)
            .padding(Edge.Set.horizontal, 16)
            .navigationTitle("Cadastro")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarBackButtonHidden()
            .navigationDestination(isPresented: $viewModel.isRequestSucessfull) {
                LoginView()
            }
        }.scrollIndicators(.hidden)
    }
}

#Preview {
    RegisterView()
}
