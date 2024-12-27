//
//  LoginView.swift
//  Vollmed
//
//  Created by Rafael Seron on 22/08/24.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel: LoginViewModel = .init()

    var body: some View {
        ScrollView {
            Spacer(minLength: 50.0)
                .frame(height: 50)
            VStack(spacing: 16) {
                Image(.logo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                    .padding(.top)

                Text("Olá!")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top)
                    .bold()
                    .foregroundStyle(.accent)
                    .font(.title3)

                Text("Preencha para acessar sua conta")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)

                Text("Email")
                    .padding(.top)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .bold()
                    .foregroundStyle(.accent)
                    .font(.title3)

                TextField("Seu e-mail aqui", text: $viewModel.emailText)
                    .padding()
                    .foregroundStyle(.accent)
                    .scrollContentBackground(.hidden)
                    .background(Color(.accent).opacity(0.1))
                    .frame(maxHeight: 48)
                    .clipShape(.buttonBorder)
                    .padding(.horizontal)
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)

                Text("Senha")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .bold()
                    .foregroundStyle(.accent)
                    .font(.title3)

                SecureField("Sua senha aqui", text: $viewModel.passwordText)
                    .padding()
                    .foregroundStyle(.accent)
                    .scrollContentBackground(.hidden)
                    .background(Color(.accent).opacity(0.1))
                    .frame(maxHeight: 48)
                    .clipShape(.buttonBorder)
                    .padding(.horizontal)
                    .textInputAutocapitalization(.never)

                Button(action: {
                    viewModel.isLoading = true
                    Task {
                        await viewModel.login(login: LoginRequest(email: viewModel.emailText, password: viewModel.passwordText))
                    }
                }, label: {
                    ButtonView(text: "Entrar")
                        .padding(.horizontal)
                }).alert(viewModel.alertMessage, isPresented: $viewModel.showAlert) {
                    Button("Ok") { viewModel.showAlert = false }
                }

                NavigationLink {
                    RegisterView()
                } label: {
                    Text("Ainda não possui uma conta? Cadastre-se.")
                        .font(.system(size: 18))
                        .bold()
                }
            }
            .navigationTitle("Entrar")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarBackButtonHidden()
            .navigationDestination(isPresented: $viewModel.isAuthenticated) {
                HomeView()
            }
        }.scrollIndicators(.hidden)
            .overlay {
                if viewModel.isLoading {
                    ProgressOverlay()
                }
            }
    }
}

#Preview {
    LoginView()
}
