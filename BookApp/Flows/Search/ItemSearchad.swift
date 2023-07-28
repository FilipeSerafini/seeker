//
//  ItemSearchad.swift
//  BookApp
//
//  Created by Sabrina Souza on 28/07/23.
//

import SwiftUI

struct ItemSearchad: View {
    @State private var isLinkActive = false
    
    var body: some View {
        NavigationView{
            NavigationLink(destination: BookView(), isActive: $isLinkActive) {
                HStack{
                    VStack{
                        Image("pequeno")
                            .resizable()
                            .scaledToFill()
                    }
                    .frame(width: 95, height: 136)
                    .cornerRadius(8)
                    
                    VStack(alignment: .leading){
                        Text("Book Author")
                            .font(.system(size: 13))
                        Text("Book Title")
                            .font(.system(size: 22, weight: .medium, design: .serif))
                        Text("Sinopse")
                            .font(.system(size: 15))
                    }
                }
                .onTapGesture {
                    isLinkActive = true
                }
            }
        }
        .foregroundColor(.black)
        .frame(width: 250, height: 140, alignment: .topLeading)
    }
}

struct ItemSearchad_Previews: PreviewProvider {
    static var previews: some View {
        ItemSearchad()
    }
}
