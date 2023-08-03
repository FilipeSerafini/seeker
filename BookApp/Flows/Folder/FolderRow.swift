//
//  FolderRow.swift
//  BookApp
//
//  Created by Filipe Serafini on 03/08/23.
//

import SwiftUI

struct FolderRow: View {
    
    @State var folder: Folder
    @State var imageName: String
    
    var body: some View {
        HStack {
            Text(folder.name)
                .font(.system(size: 17, weight: .regular))
            
            Spacer()
            Image(imageName)
            
        }
        .padding(29)
    }
}

struct FolderRow_Previews: PreviewProvider {
    static var previews: some View {
        FolderRow(folder: Folder(books: [], description: "a", name: "Melhores!")!, imageName: "folderUnselected")
    }
}
