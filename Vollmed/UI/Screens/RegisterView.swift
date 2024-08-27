//
//  RegisterView.swift
//  Vollmed
//
//  Created by Rafael Seron on 26/08/24.
//

import SwiftUI

struct RegisterView: View {
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
                
                Text("Olá, boas vindas!")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top)
                    .bold()
                    .foregroundStyle(.accent)
                    .font(.title3)
                
                Text("Insira seus dados para criar uma conta.")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                
            }.navigationTitle("Cadastro")
                .navigationBarTitleDisplayMode(.large)
        }.scrollIndicators(.hidden)
        
    }
}

#Preview {
    RegisterView()
}
