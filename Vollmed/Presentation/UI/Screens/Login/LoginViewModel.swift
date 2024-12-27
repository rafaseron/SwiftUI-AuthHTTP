//
//  LoginViewModel.swift
//  Vollmed
//
//  Created by Rafael Seron on 27/12/24.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var emailText: String = ""
    @Published var passwordText: String = ""
    @Published var isAuthenticated: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var isLoading: Bool = false

    func login(login: LoginRequest) async {
        do {
            let result = try await WebService.shared.login(login: login)
            UserDefaultsHelper.save(forKey: UserDefaultsKeys.jwtToken.rawValue, value: result.token)
            UserDefaultsHelper.save(forKey: UserDefaultsKeys.userId.rawValue, value: result.id)
            isLoading = false
            isAuthenticated = true
        } catch let error as RequestError {
            switch error {
            case .invalidPassword:
                self.alertMessage = "Senha inválida"
            case .userNotFound:
                self.alertMessage = "Usuário não encontrado"
            default:
                self.alertMessage = "Ocorreu um erro. Tente novamente"
            }
            self.isLoading = false
            self.showAlert = true
        } catch {
            isLoading = false
            alertMessage = "Ocorreu um erro. Tente novamnete"
            showAlert = true
        }
    }
}
