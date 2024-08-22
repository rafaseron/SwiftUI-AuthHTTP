//
//  TabView.swift
//  Vollmed
//
//  Created by Rafael Seron on 02/07/24.
//

import SwiftUI

struct AppTabView: View {
    var body: some View {
        TabView {
            // Item 1 da TabView
            NavigationStack{
                HomeView()
            }.tabItem {
                Label(
                    title: { Text("Medicos") },
                    icon: { Image(systemName: "house") }
                )
            }
            // Item 2 da TabView
            NavigationStack{
                ConsultasView()
            }.tabItem { Label(
                title: { Text("Minhas consultas") },
                icon: { Image(systemName: "calendar") }
            ) }
            
        }
    }
}

#Preview {
    AppTabView()
}
