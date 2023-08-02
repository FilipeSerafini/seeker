//
//  SearchViewTeste.swift
//  BookApp
//
//  Created by Sabrina Souza on 02/08/23.
//

import SwiftUI

struct SearchViewTeste: View {
    
    @EnvironmentObject private var searchViewModel: SearchViewModel

    var body: some View {
        NavigationStack {
           // ScrollView{
                VStack {
                    SearchableView()
                }
                
               // VStack {
//                    VStack {
//                        HStack{
//                            Text("You might like")
//                                .font(.system(size: 17, weight: .semibold, design: .serif))
//                                .padding(.leading)
//                            Spacer()
//                        }
//                        ScrollView(.horizontal, showsIndicators: false){
//                            HStack(spacing: 0){
//                                ForEach(searchViewModel.books) { book in
//                                    ItemSearch(book: book)
//                                }
//                                .padding(.leading)
//                            }
//                        }
//                    }
//                    .padding(.bottom)
//
//                    VStack{
//                        HStack {
//                            Text("Romance books")
//                                .font(.system(size: 17, weight: .semibold, design: .serif))
//                                .padding(.leading)
//                            Spacer()
//                        }
//                        ScrollView(.horizontal, showsIndicators: false){
//                            HStack(spacing: 0){
//                                ForEach(searchViewModel.books) { book in
//                                    ItemSearch(book: book)
//                                }
//                                .padding(.leading)
//                            }
//                        }
//                    }
//                    .padding(.bottom)
//
//                    VStack(alignment: .leading){
//                        HStack {
//                            Text("More from Rupi Kaur")
//                                .font(.system(size: 17, weight: .semibold, design: .serif))
//                                .padding(.leading)
//                            Spacer()
//                        }
//
//                        ScrollView(.horizontal, showsIndicators: false){
//                            HStack(spacing: 0){
//                                ForEach(searchViewModel.books) { book in
//                                    ItemSearch(book: book)
//                                }
//                                .padding(.leading)
//                            }
//                        }
//
//                    }
                }
           // }
          //  .navigationBarTitle("Search")
        }
}

struct SearchViewTeste_Previews: PreviewProvider {
    static var previews: some View {
        SearchViewTeste()
    }
}
