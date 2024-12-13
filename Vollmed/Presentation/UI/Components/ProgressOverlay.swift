//
//  ProgressOverlay.swift
//  Vollmed
//
//  Created by Rafael Seron on 13/12/24.
//

import SwiftUI

struct ProgressOverlay: View {
    var body: some View {
        ZStack {
            // Fundo semitransparente
            Color.black.opacity(0.4)
                .ignoresSafeArea()

            // Indicador de carregamento
            ProgressView("Carregando...")
                .progressViewStyle(.circular)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
        }.navigationBarBackButtonHidden()
    }
}

#Preview {
    ProgressOverlay()
}
