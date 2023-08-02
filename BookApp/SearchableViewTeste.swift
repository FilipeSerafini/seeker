//
//  SearchableViewTeste.swift
//  BookApp
//
//  Created by Sabrina Souza on 02/08/23.
//

import SwiftUI

struct SearchableViewTeste: View {
    @State private var searchText = ""
    @EnvironmentObject private var searchViewModel: SearchViewModel
    
    @State private var isEditing: Bool = false
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    // Search Bar
                    HStack {
                        TextField("Procure por livros, autores e gêneros", text: $searchText,  onEditingChanged: { editing in
                            isEditing = editing
                        })
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
                    
                    if !isEditing && searchText == "" {
                        VStack {
                            VStack {
                                HStack{
                                    Text("You might like")
                                        .font(.system(size: 17, weight: .semibold, design: .serif))
                                        .padding(.leading)
                                    Spacer()
                                }
                                ScrollView(.horizontal, showsIndicators: false){
                                    HStack(spacing: 0){
                                        ForEach(searchViewModel.books) { book in
                                            BookResearchedCover(book: book)
                                        }
                                        .padding(.leading)
                                    }
                                }
                            }
                            .padding(.bottom)
                            
                            VStack{
                                HStack {
                                    Text("Romance books")
                                        .font(.system(size: 17, weight: .semibold, design: .serif))
                                        .padding(.leading)
                                    Spacer()
                                }
                                ScrollView(.horizontal, showsIndicators: false){
                                    HStack(spacing: 0){
                                        ForEach(searchViewModel.books) { book in
                                            BookResearchedCover(book: book)
                                        }
                                        .padding(.leading)
                                    }
                                }
                            }
                            .padding(.bottom)
                            
                            VStack(alignment: .leading){
                                HStack {
                                    Text("More from Rupi Kaur")
                                        .font(.system(size: 17, weight: .semibold, design: .serif))
                                        .padding(.leading)
                                    Spacer()
                                }
                                
                                ScrollView(.horizontal, showsIndicators: false){
                                    HStack(spacing: 0){
                                        ForEach(searchViewModel.books) { book in
                                            BookResearchedCover(book: book)
                                        }
                                        .padding(.leading)
                                    }
                                }
                                
                            }
                        }
                    } else if searchText == "" && isEditing{
                        Group {
                            Text("ta vazio") // Visualização vazia para ocupar o espaço
                        }.onAppear {
                            zerarPesquisa()
                        }
                        
                    } else if !isEditing {
                        ForEach(searchViewModel.books) { book in
                            ResearchedBookView(book: book)
                        }
                    }
                }
            }
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil) //teclado some ao clicar na tela
            }
        }
        .navigationBarTitle("Search")
    }
    
    func zerarPesquisa() {
        searchViewModel.fetchBooks(searchedText: searchText)
    }

}

struct SearchableViewTeste_Previews: PreviewProvider {
    static var previews: some View {
        SearchableViewTeste()
    }
}
