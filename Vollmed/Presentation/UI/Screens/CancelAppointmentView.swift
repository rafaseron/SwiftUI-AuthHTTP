//
//  CancelAppointmentView.swift
//  Vollmed
//
//  Created by Rafael Seron on 20/08/24.
//

import SwiftUI

struct CancelAppointmentView: View {
    @Environment(\.presentationMode) var presentationMode
    
    let service = WebService()
    let appointmentId: String?
    
    @State private var newTextValue: String = ""
    @State private var isShowAlert: Bool = false
    @State private var responseMessage: String = "A consulta deve ser desmarcada com 1 dia de antecedência"
    
    var body: some View {
        LazyVStack(spacing: 8){
            Text("Qual seria o motivo do cancelamento?")
                .font(.title3)
                .bold()
                .foregroundStyle(.accent)
                .padding(.top)
            
            Text("cancelamentos são permitidos somente com antecedência mínima de 1 dia")
                .font(.title3)
                .bold()
                .foregroundStyle(.cancel)
                .padding(.bottom)
            
            
            TextEditor(text: $newTextValue)
                .padding()
                .font(.title3)
                .foregroundStyle(.accent)
                .scrollContentBackground(.hidden)
                .background(Color(.secondarySystemBackground))
                .frame(minHeight: 200, maxHeight: 300)
                .clipShape(.buttonBorder)
                .padding(.horizontal)
                
            
            Button(action: {
                Task{
                    await onDeleteClick()
                }
                
            }, label: {
                ButtonView(text: "Cancelar consulta", buttonType: .cancel)
                    .padding(.horizontal)
            }).alert("Cancelamento", isPresented: $isShowAlert, presenting: {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("OK")
                })
            }, actions: { _ in
                Text("OK")
                
            }, message: { _ in
                Text(responseMessage)
            })
            
        }.navigationTitle("Cancelar")
            .navigationBarTitleDisplayMode(.large)
        
    }
    // MARK: - Escopo da Struct CancelAppointmentView
    
    func onDeleteClick() async{
        guard let Id = appointmentId else {
            return
        }
        do{
            let deleteResponse = try await service.deleteAppointment(appointmentId: Id, cancelReason: newTextValue)
            
            if deleteResponse{
                responseMessage = "Pedido de cancelamento enviado"
                isShowAlert = true
            }
            
            isShowAlert = true
            
        }catch{
            print(error)
            responseMessage = "Erro ao tentar cancelar"
            isShowAlert = true
        }
        
    }
    
}

#Preview {
    CancelAppointmentView(appointmentId: "")
}
