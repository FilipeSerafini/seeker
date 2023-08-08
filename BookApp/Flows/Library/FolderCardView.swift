import SwiftUI

struct FolderCardView: View {
    var body: some View {
        
        VStack{
            Text("Folder Name")
            Text("Colocar livros aqui")
            Text("Poder editar o restante")
        }
    }
}

struct FolderCardView_Previews: PreviewProvider {
    static var previews: some View {
        FolderCardView()
    }
}
