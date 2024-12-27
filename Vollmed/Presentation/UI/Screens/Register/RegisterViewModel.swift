//
//  RegisterViewModel.swift
//  Vollmed
//
//  Created by Rafael Seron on 27/12/24.
//

import Foundation

class RegisterViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var phoneNumber: String = ""
    @Published var email: String = ""
    @Published var cpf: String = ""
    @Published var password: String = ""
    @Published var selectedPlan: String = ""
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var isRequestSucessfull: Bool = false

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

    /// Register Patient request
    func registerPatient() async {
        do {
            let patient = Patient(id: nil, cpf: cpf, name: name, email: email, password: password, phone: phoneNumber, healthPlan: selectedPlan)
            let _ = try await WebService.shared.registerPatient(patient: patient)
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
