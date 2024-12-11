//
//  LoginView.swift
//  Vollmed
//
//  Created by Rafael Seron on 22/08/24.
//

import SwiftUI

struct LoginView: View {
    let service = WebService()

    @State var emailText: String = ""
    @State var passwordText: String = ""
    @State var isAuthenticated: Bool = false
    @State var showAlert: Bool = false
    @State var alertMessage: String = ""


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

                TextField("Seu e-mail aqui", text: $emailText)
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

                SecureField("Sua senha aqui", text: $passwordText)
                    .padding()
                    .foregroundStyle(.accent)
                    .scrollContentBackground(.hidden)
                    .background(Color(.accent).opacity(0.1))
                    .frame(maxHeight: 48)
                    .clipShape(.buttonBorder)
                    .padding(.horizontal)

                Button(action: {
                    Task {
                        let response = await login(login: LoginRequest(email: emailText, password: passwordText))
                        if response != nil {
                            isAuthenticated = true
                            return
                        }
                        isAuthenticated = false
                        alertMessage = "Oops! algo deu errado. Tente novamente."
                        showAlert = true
                        return
                    }
                }, label: {
                    ButtonView(text: "Entrar")
                        .padding(.horizontal)
                }).alert(alertMessage, isPresented: $showAlert) {
                    Button("Ok") { showAlert = false }
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
            .navigationDestination(isPresented: $isAuthenticated) {
                HomeView()
            }
        }.scrollIndicators(.hidden)
    }

    func login(login: LoginRequest) async -> LoginResponse? {
        do {
            let result = try await service.login(login: login)
            return result
        } catch {
            return nil
        }
    }
}

#Preview {
    LoginView()
}
