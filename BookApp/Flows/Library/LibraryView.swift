import SwiftUI

struct LibraryView: View {
    
    var userName: String = ""
    //    @EnvironmentObject private var searchViewModel: SearchViewModel
    @EnvironmentObject private var userManager: UserManager
    
    @StateObject private var viewModel: LibraryViewModel = LibraryViewModel()
    @State private var isPresented: Bool = false
    @State private var folderName: String = ""
    
    @Environment(\.colorScheme) var scheme
    @State private var startConfirm = false
    
    var body: some View {
        VStack{
            NavigationStack {
                HStack{
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
                    }
                label: {
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
                }message: {
                    Text("Insira o nome desejado para a pasta.")
                }
                }
                .padding(.top, 20)
                .padding()
            }
            
            VStack{
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(spacing: 0) {
                        
                        ForEach(folders) {folder in
                            FolderView(folder: folders[1])
                        }
                    }
                }
                .coordinateSpace(name: "SCROLL")
            }
            .padding([.horizontal, .trailing])
            .navigationBarTitle("")
        }
    }
}



struct Previews_LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}
