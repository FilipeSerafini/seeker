//
//  SearchView.swift
//  BookApp
//
//  Created by Sabrina Souza on 27/07/23.
//

import SwiftUI

struct SearchView: View {
    @State private var searchBooks = ""
    @State private var showSearchResults = false
    @State private var showDefaultList = true
        
    var body: some View {
        NavigationStack {
            ScrollView{
                
                if !showSearchResults {
                    
                    VStack {
                        HStack {
                            Text("You might like")
                                .font(.system(size: 17, weight: .semibold, design: .serif))
                                .padding(.leading)
                            Spacer()
                        }
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack{
                                ItemSearch()
                                    .padding(.leading)
                                ItemSearch()
                                ItemSearch()
                                ItemSearch()
                                ItemSearch()
                                ItemSearch()
                                ItemSearch()
                                ItemSearch()
                                ItemSearch()
                                ItemSearch()
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
                            HStack{
                                ItemSearch()
                                    .padding(.leading)
                                ItemSearch()
                                ItemSearch()
                                ItemSearch()
                                ItemSearch()
                                ItemSearch()
                                ItemSearch()
                                ItemSearch()
                                ItemSearch()
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
                            HStack{
                                ItemSearch()
                                    .padding(.leading)
                                ItemSearch()
                                ItemSearch()
                                ItemSearch()
                                ItemSearch()
                                ItemSearch()
                                ItemSearch()
                                ItemSearch()
                                ItemSearch()
                            }
                        }

                    }
                }
                else {
                    ItemSearchad()
                }
            }

//            .navigationTitle("Search")
        }
        .searchable(text: $searchBooks, prompt: "Search for books, authors and genres")
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
