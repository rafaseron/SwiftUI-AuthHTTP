//
//  WebService.swift
//  Vollmed
//
//  Created by Giovanna Moeller on 12/09/23.
//

import UIKit

// usar UIImage faz com que seja preciso importar o UIKit

struct WebService {
    let patientId: String = "61c55f06-aeb9-4ef7-a706-6a29e6eccbc8"

    // MARK: - BASE URL

    private let baseURL = "http://192.168.13.220:3000"

    enum RequestError: Error {
        case invalidURL
        case requestError
    }

    /// Function to prepare the baseURL
    ///
    /// - Parameter endpoint: request endpoint, it is optional when calling the function
    /// - Returns: URL prepared from the baseURL
    /// - Throws: returns nil if it fails
    func getBaseURL(_ endpoint: String = "") throws -> URL {
        if let url = URL(string: "\(baseURL)\(endpoint)") {
            return url
        }
        throw RequestError.invalidURL
    }

    // MARK: - SPECIALISTS

    func getAllSpecialists() async throws -> [Specialist]? {
        // Preparar a URL
        let getEndpoint = "\(baseURL)/especialista"

        guard let url = URL(string: getEndpoint) else {
            print("URL Error")
            return nil
        }

        // Prepar o Request
        var getRequest = URLRequest(url: url)
        getRequest.httpMethod = "GET"

        // Iniciar a Sessao
        let (data, _) = try await URLSession.shared.data(for: getRequest)

        // Decodificar o 'Data' recebido na Sessao e retornar
        let dataDecode = try JSONDecoder().decode([Specialist].self, from: data)
        return dataDecode
    }

    // MARK: - ASYNCIMAGE

    /// Async Image
    ///
    /// - Parameter url: the URL as a String of the Image
    /// - Returns: returns an optional UIImage, which can be used to display an Image in SwiftUI, if it is not nil
    /// - Throws: may fail during request, which will throw an Error
    func asyncImage(from url: String) async throws -> UIImage? {
        guard let imageEndPoint = URL(string: url) else {
            return nil
        }
        let (data, _) = try await URLSession.shared.data(from: imageEndPoint)
        let dataImage = UIImage(data: data)
        return dataImage
    }

    // MARK: - APPOINTMENTS

    func postAppointment(specialistId: String, patientId: String, date: String) async throws -> ScheduleResponse? {
        let endpoint = baseURL + "/consulta"
        // método http -> POST

        // Preparar a URL
        guard let url = URL(string: endpoint) else {
            return nil
        }

        // Fazer Enconde dos dados da aplicacao para serem enviados na Requisicao
        // Perceba que usamos o type como Request de schedule
        let data = try JSONEncoder().encode(ScheduleRequest(specialistID: specialistId, patientID: patientId, date: date))

        print("data -> \(date)")
        print("patientId -> \(patientId)")
        print("specialistId -> \(specialistId)")

        // Definir o método HTTP, o Body e o Header
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type") // Header
        request.httpBody = data // Body

        // Por fim, iniciar a Sessao usando o Request feito anteriormente
        let session = try await URLSession.shared.data(for: request)

        // Agora vamos Decodificar o Data recebido após Sessao
        // Perceba que usamos o type como Response de schedule
        let dataResponse = try JSONDecoder().decode(ScheduleResponse.self, from: session.0)
        return dataResponse
    }

    func getAppointmentsByPatientId(idPaciente: String) async throws -> [Appointment]? {
        let endpoint: String = baseURL + "/paciente/" + idPaciente + "/consultas"

        guard let url = URL(string: endpoint) else {
            return nil
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let session = try await URLSession.shared.data(for: request)
        let data = session.0
        // let response = session.1

        let decodedData = try JSONDecoder().decode([Appointment].self, from: data)
        return decodedData
    }

    func updateAppointment(newDate: String, appointmentId: String) async throws -> ScheduleResponse? {
        // Preparar URL
        let endpoint = baseURL + "/consulta/" + appointmentId
        guard let url = URL(string: endpoint) else {
            return nil
        }

        // Preparar Request
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type") // especificar o tipo de conteúdo para a API - necessário

        // Preparar Body do Request
        let messageDictionary = ["data": "\(newDate)"]
        let body = try JSONEncoder().encode(messageDictionary)
        request.httpBody = body

        // Preparar Body do Request - método feito pela Giovanna
        // let messageDictionary: [String : String] = ["data" : "\(newDate)"]
        // let body = try JSONSerialization.data(withJSONObject: messageDictionary)
        // request.httpBody = body

        // Iniciar a Sessao
        let session = try await URLSession.shared.data(for: request)
        let data = session.0
        // let response = session.1

        let response = try JSONDecoder().decode(ScheduleResponse.self, from: data)
        return response
    }

    func deleteAppointment(appointmentId: String, cancelReason: String) async throws -> Bool {
        // Preparar a URL
        let endpoint = baseURL + "/consulta/" + appointmentId

        guard let url = URL(string: endpoint) else {
            return false
        }

        // Preparar Request
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // Preparar o Body do Request
        let cancelReasonDictionary: [String: String] = ["motivo_cancelamento": cancelReason]
        request.httpBody = try JSONEncoder().encode(cancelReasonDictionary)

        // Iniciar a Sessao
        let session = try await URLSession.shared.data(for: request)
        let response = session.1

        guard let httpResponse = response as? HTTPURLResponse else {
            return false
        }

        if httpResponse.statusCode != 200 {
            return false
        }

        return true
    }

    /// Function to register a Patient
    ///
    /// - Parameter patient: is the Model that represents a Patient
    /// - Throws: requestError if there is any problem
    func registerPatient(patient: Patient) async throws -> Patient {
        do {
            let url = try getBaseURL("/paciente")
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = try JSONEncoder().encode(patient)
            request.allHTTPHeaderFields = ["Content-Type": "application/json"]

            let response = try await URLSession.shared.data(for: request)

            let decodedData = try JSONDecoder().decode(Patient.self, from: response.0)
            return decodedData

        } catch {
            throw RequestError.requestError
        }
    }

    /// Function to make Login
    ///
    /// - Parameter login: request model for Login on API
    /// - Returns LoginResponse: response model from API for Login
    /// - Throws: may return an exception or return nil if something goes wrong
    func login(login: LoginRequest) async throws -> LoginResponse? {
        guard let url = URL(string: "\(baseURL)/auth/login") else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try JSONEncoder().encode(login)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = try await URLSession.shared.data(for: request)
        let decodedData = try JSONDecoder().decode(LoginResponse.self, from: session.0)
        return decodedData
    }
}
