//
//  HomeViewModel.swift
//  Vollmed
//
//  Created by Rafael Seron on 20/12/24.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var especialistasList: [Specialist] = []
    @Published var isNotAuthenticated: Bool = false

    func fetchSpecialists() async {
        do {
            let specialists = try await WebService.shared.getAllSpecialists()
            especialistasList = specialists

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
