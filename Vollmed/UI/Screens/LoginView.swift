//
//  LoginView.swift
//  Vollmed
//
//  Created by Rafael Seron on 22/08/24.
//

import SwiftUI

struct LoginView: View {
    
    
    @State var emailText: String = ""
    @State var passwordText: String = ""
    
    
    var body: some View {
        VStack(spacing: 16){
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
            
            TextEditor(text: $emailText)
                .padding()
                .foregroundStyle(.accent)
                .scrollContentBackground(.hidden)
                .background(Color(.accent).opacity(0.1))
                .frame(maxHeight: 48)
                .clipShape(.buttonBorder)
                .padding(.horizontal)
            
            
            Text("Senha")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .bold()
                .foregroundStyle(.accent)
                .font(.title3)
            
            TextEditor(text: $passwordText)
                .padding()
                .foregroundStyle(.accent)
                .scrollContentBackground(.hidden)
                .background(Color(.accent).opacity(0.1))
                .frame(maxHeight: 48)
                .clipShape(.buttonBorder)
                .padding(.horizontal)
            
            ButtonView(text: "Entrar")
                .padding(.horizontal)
            
            Button(action: {
                print("botao de Cadastrar pressionado")
            }, label: {
                Text("Ainda não possui uma conta? Cadastre-se.")
                    .font(.system(size: 18))
                    .bold()
            })
            
        }
        
    }
}

#Preview {
    LoginView()
}
