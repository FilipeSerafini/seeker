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
        NavigationView{
            NavigationLink(destination: BookView(), isActive: $isLinkActive, label: {
                VStack{
                    Image("pequeno")
                        .resizable()
                        .scaledToFill()
                        .onTapGesture {
                            isLinkActive = true
                        }
                }
                .frame(width: 95, height: 136)
                .cornerRadius(8)
            }
            )
        }
        .frame(width: 100, height: 136)
    }
}
struct ItemSearch_Previews: PreviewProvider {
    static var previews: some View {
        ItemSearch()
    }
}
