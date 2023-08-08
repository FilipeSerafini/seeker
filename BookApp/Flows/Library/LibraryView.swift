import SwiftUI

struct LibraryView: View {
    
    @State var expandFolder: Bool = false
    var userName: String = ""
    @EnvironmentObject private var userManager: UserManager
    @StateObject private var viewModel: LibraryViewModel = LibraryViewModel()
    @State private var isPresented: Bool = false
    @State private var folderName: String = ""
    @Environment(\.colorScheme) var scheme
    @State private var startConfirm = false
    
    var body: some View {
        NavigationStack {
            VStack{
                
                HStack {
                    VStack (alignment: .leading){
                        // Text("E aí, \(userName)?")
                        Text("E aí, Manu?")
                            .font(.system(size: 15))
                        Text("Minha Estante")
                            .font(.system(size: 34, design: .serif))
                    }
                    Spacer()
                    
                    Button {
                        isPresented.toggle()
                    } label: {
                        Image("addFolders")
                            .resizable()
                            .frame(width: 46, height: 34)
                    }
                    .alert("Criar nova pasta", isPresented: $isPresented) {
                        TextField(folderName, text: $folderName)
                        Button("Cancelar",action: {})
                        Button("Salvar",action: {
                            //                    viewModel.createFolder(folderName: folderName)
                            userManager.createFolder(folderName: folderName)
                        })
                    } message: {
                        Text("Insira o nome desejado para a pasta.")
                    }
                }
                .padding()
                
                Spacer()
                
                VStack {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 0) {
                            ForEach(folders) { folder in
                                FolderView(folder: folder)
                            }
                        }
                    }
                    .coordinateSpace(name: "SCROLL")
                }
                .padding([.horizontal, .trailing])
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
            .background(
                Image("backgroundImage")
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
            )
        }
        
    }
    
    //Retreiving Index
    func getIndex(folder: FolderCard)->Int{
        return folders.firstIndex { currentFolder in
            return currentFolder.id == folder.id
        } ?? 0
    }
}


struct Previews_LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}
