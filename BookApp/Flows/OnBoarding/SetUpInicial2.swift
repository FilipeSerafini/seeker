//
//  SetUpInicial2.swift
//  BookApp
//
//  Created by Sabrina Souza on 09/08/23.
//

import SwiftUI

struct SetUpInicial2: View {
    @State private var username = ""
    @State private var name = ""
    @State private var isEditing: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack{
                VStack{
                    Text("Vamos nos conhecer melhor!\nQuais são seus gêneros literários favoritos?")   .multilineTextAlignment(.center)
                        .font(.system(size: 17, weight: .regular))
                        .padding(.bottom)
                    
                    Text("Escolha ao menos três para prosseguir.")
                        .multilineTextAlignment(.center)
                        .font(.system(size: 15))
                }
                
                VStack {
                    GenreButtonOnboarding()
                }
                .padding(.top, 50)
                
                NavigationLink(destination: LibraryView().navigationBarBackButtonHidden(true), label: {
                    ZStack {
                        Rectangle()
                            .fill(Color("primary"))
                            .cornerRadius(30)
                            .frame(width: 100, height: 45)
                        Text("Começar")
                            .foregroundColor(.white)
                    }
                    
                })
                // .disabled(username == "")
                // .opacity(username == "" ? 0.6 : 1)
                .padding(.top, 60)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Image("backgroundImage")
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
            )
        }
    }
}

struct SetUpInicial2_Previews: PreviewProvider {
    static var previews: some View {
        SetUpInicial2()
    }
}
