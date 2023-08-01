//
//  sea.swift
//  BookApp
//
//  Created by Sabrina Souza on 28/07/23.
//

import SwiftUI

struct ItemSearch: View {
    
    @State private var isLinkActive = false
    let book: Book
    
    var body: some View {
        NavigationStack{
            VStack{
                Image(uiImage: book.imageCover ?? UIImage(named: "bookImage")!)
                    .resizable()
                    .scaledToFill()
                    .onTapGesture {
                        isLinkActive = true
                    }
            }
            .frame(width: 95, height: 136)
            .cornerRadius(8)
            .navigationDestination(isPresented: $isLinkActive, destination: { BookView() })
        }
    }
}
//struct ItemSearch_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemSearch()
//    }
//}
