//
//  addToFolderHeader.swift
//  BookApp
//
//  Created by Filipe Serafini on 04/08/23.
//

import SwiftUI

struct addToFolderHeader: View {
    var body: some View {
        HStack {
            Spacer()
            Text("Adicionar a uma lista")
                .font(.system(size: 22, weight: .medium, design: .serif))
            Spacer()
            Button {
                
            } label: {
                Image("saveFolder")
            }
            Spacer()
            
        }
        .padding(.top)
    }
}

struct addToFolderHeader_Previews: PreviewProvider {
    static var previews: some View {
        addToFolderHeader()
    }
}
