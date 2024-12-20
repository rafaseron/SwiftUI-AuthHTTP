//
//  RegisterView.swift
//  Vollmed
//
//  Created by Rafael Seron on 26/08/24.
//

import SwiftUI

struct RegisterView: View {
    let service: WebService = .init()

    @State var name: String = ""
    @State var phoneNumber: String = ""
    @State var email: String = ""
    @State var cpf: String = ""
    @State var password: String = ""
    @State var selectedPlan: String = ""
    @State var showAlert: Bool = false
    @State var alertMessage: String = ""
    @State var isRequestSucessfull: Bool = false

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

                TextField("Digite seu nome", text: $name)
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

                TextField("Digite seu telefone", text: $phoneNumber)
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

                TextField("Digite seu CPF", text: $cpf)
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
                    text: $email
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

                SecureField("Digite sua senha", text: $password)
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

                    Picker("Selecione seu plano de saúde", selection: $selectedPlan) {
                        ForEach(healPlanList, id: \.self) { plan in
                            Text(plan)
                        }
                    }
                }

                Button {
                    let result = validateFields()
                    if !result {
                        alertMessage = "Preencha todos os campos"
                        showAlert = true
                        return
                    }
                    if selectedPlan == "" {
                        alertMessage = "Você deve selecionar um Plano de Saúde"
                        showAlert = true
                        return
                    }
                    Task {
                        await registerPatient()
                    }

                } label: {
                    ButtonView(text: "Cadastrar")
                }.alert(alertMessage, isPresented: $showAlert) {
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
            .navigationDestination(isPresented: $isRequestSucessfull) {
                LoginView()
            }
        }.scrollIndicators(.hidden)
    }
    
    /// Personal information forms validation
    ///
    /// - Returns false if forms are empty
    /// - Returns true if forms are not empty
    func validateFields() -> Bool {
        if cpf.isEmpty || name.isEmpty || email.isEmpty || password.isEmpty || phoneNumber.isEmpty {
            return false
        }
        return true
    }

    func registerPatient() async {
        do {
            let patient = Patient(id: nil, cpf: cpf, name: name, email: email, password: password, phone: phoneNumber, healthPlan: selectedPlan)
            let _ = try await service.registerPatient(patient: patient)
            alertMessage = "Cadastro realizado com sucesso! Você será redirecionado para o Login."
            showAlert = true
            try await Task.sleep(nanoseconds: 2_000_000_000)
            isRequestSucessfull = true
        } catch {
            showAlert = true
            alertMessage = "Ocorreu um erro. Tente novamente mais tarde"
        }
    }
}

#Preview {
    RegisterView()
}
