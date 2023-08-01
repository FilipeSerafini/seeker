//
//  SwiftUIView.swift
//  testesparaoBooks
//
//  Created by Sabrina Souza on 30/07/23.
//

import SwiftUI

struct SearchableView: View {
    @State private var searchText = ""
    @State private var filteredData: [String] = []
    @EnvironmentObject private var searchViewModel: SearchViewModel
    
    var body: some View {
            VStack(alignment: .leading) {
                // Search Bar
                HStack {
                    TextField("Procure por livros, autores e gêneros", text: $searchText)
                        .onSubmit {
                            searchViewModel.fetchBooks(searchedText: searchText)
                        }
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
                            searchViewModel.fetchBooks(searchedText: searchText)
                            
                            print("Pesquisar...")
                        }) {
                            Image("searchIconSelected")
                                .padding(.trailing, 25)
                        }
                        .disabled(searchText == "")
                        .opacity(searchText == "" ? 0.6 : 1)
                    }
                )
                
                ForEach(searchViewModel.books) { book in
                    ItemSearchad(book: book)
                }
            }
    }
    
    /*
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
     */
}

struct Searchable_Previews: PreviewProvider {
    static var previews: some View {
        SearchableView()
    }
}
