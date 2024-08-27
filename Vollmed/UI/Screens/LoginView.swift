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
        ScrollView{
            Spacer()
                .frame(height: 50)
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
            
            TextField("seu e-mail aqui", text: $emailText)
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
            
            SecureField("sua senha aqui", text: $passwordText)
                .padding()
                .foregroundStyle(.accent)
                .scrollContentBackground(.hidden)
                .background(Color(.accent).opacity(0.1))
                .frame(maxHeight: 48)
                .clipShape(.buttonBorder)
                .padding(.horizontal)
            
            Button(action: {
                print("Botao de Entrar pressionado")
            }, label: {
                ButtonView(text: "Entrar")
                    .padding(.horizontal)
            })
            
            NavigationLink {
                RegisterView()
            } label: {
                Text("Ainda não possui uma conta? Cadastre-se.")
                    .font(.system(size: 18))
                    .bold()
            }


        }.navigationTitle("Entrar")
            .navigationBarTitleDisplayMode(.large)
        }.scrollIndicators(.hidden)
        
        
    }
}

#Preview {
    LoginView()
}
