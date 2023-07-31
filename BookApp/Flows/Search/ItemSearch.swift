//
//  sea.swift
//  BookApp
//
//  Created by Sabrina Souza on 28/07/23.
//

import SwiftUI

struct ItemSearch: View {
    
    @State private var isLinkActive = false
    
    var body: some View {
        NavigationStack{
                VStack{
                    Image("bookImage")
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
       // .frame(width: 100, height: 136)
    }
}
struct ItemSearch_Previews: PreviewProvider {
    static var previews: some View {
        ItemSearch()
    }
}
