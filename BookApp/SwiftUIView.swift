//
//  SwiftUIView.swift
//  BookApp
//
//  Created by Sabrina Souza on 30/07/23.
//

import SwiftUI

struct Searchable: View {
    @State private var searchText = ""
    @State private var filteredData: [String] = []

    
    let data = ["Maçã", "Banana", "Laranja", "Pera", "Abacaxi", "Uva", "Morango", "Melancia"]

    
    var body: some View {
        NavigationView {
            VStack {
                // Search Bar
                HStack {
                    
                    TextField("Procure por livros, autores e gêneros", text: $searchText, onEditingChanged: { _ in
                                    performSearch()
                                })
                        .padding(15)
                        .font(.system(size: 15))
                        .foregroundColor(Color(red: 0.255, green: 0.255, blue: 0.255))
                }
                .padding(.trailing, 20)
                .background(Color(red: 0.851, green: 0.851, blue: 0.851))
                .cornerRadius(30)
                .padding()
                .overlay(
                    HStack {
                        Spacer()
                        Button(action: {
                            performSearch()

                            print("Pesquisar...")
                        }) {
                            Image("searchIconSelected")
                                .padding(.trailing, 25)
                        }
                    }
                )
                List(filteredData, id: \.self) { item in
                               Text(item)
                           }
            }
        }
    }
    func performSearch() {
            if searchText.isEmpty {
                // Se a caixa de pesquisa estiver vazia, mostra todos os dados
                filteredData = data
            } else {
                // Filtra os dados com base no texto de pesquisa
                filteredData = data.filter { item in
                    item.localizedCaseInsensitiveContains(searchText)
                }
            }
        }
}

struct Searchable_Previews: PreviewProvider {
    static var previews: some View {
        Searchable()
    }
}
