import SwiftUI

struct addToFolderView: View {
    
    @EnvironmentObject private var userManager: UserManager
    
    @State var state: String = "folderUnselected"
    
    var body: some View {
        VStack {
            
            HStack {
                Text("Adicionar a uma lista")
                    .font(.system(size: 22, weight: .medium, design: .serif))
                Image("saveFolder")
                
            }
            .padding(.top, 20)
            
            ForEach(userManager.folders) { folder in
                FolderRow(folder: folder, imageName: state)
                Divider()
                
            }
        }
        Spacer()
    }
}

struct addToFolderView_Previews: PreviewProvider {
    static var previews: some View {
        addToFolderView()
    }
}

//falar renan
