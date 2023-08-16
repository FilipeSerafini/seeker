import SwiftUI

struct FolderRow: View {
    let folder: Folder
    @State var isSelected: Bool
    @State var hasChanged: Bool = false
    let action: (Bool, Bool) -> ()
    
    var body: some View {
        VStack{
            Button {
                isSelected.toggle()
                hasChanged.toggle()
                action(isSelected, hasChanged)
            } label: {
                HStack {
                    Text(folder.name)
                        .font(.system(size: 17, weight: .regular))
                        .foregroundColor(Color("text"))
                    Spacer()
                    
                    Image(isSelected ? "folderSelected" : "folderUnselected")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
                
            }
        }
        .padding(.vertical, 5)
        .padding(.horizontal, 20)
    }
}
