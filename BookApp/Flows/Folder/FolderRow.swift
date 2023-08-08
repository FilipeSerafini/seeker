import SwiftUI

struct FolderRow: View {
    
    let folder: Folder
    @State var isSelected: Bool
    @State var hasChanged: Bool = false
    
    let action: (Bool, Bool) -> ()
    
    var body: some View {
        HStack {
            Text(folder.name)
                .font(.system(size: 17, weight: .regular))
            
            Spacer()
            Button {
                isSelected.toggle()
                hasChanged.toggle()
                action(isSelected, hasChanged)
            } label: {
                Image(isSelected ? "folderSelected" : "folderUnselected")
            }

            
            
        }
        .padding(29)
    }
}

//struct FolderRow_Previews: PreviewProvider {
//    static var previews: some View {
//        FolderRow(folder: Folder(books: [], description: "a", name: "Melhores!")!, selected: false)
//    }
//}
