import SwiftUI

struct LibraryView: View {
    
    @EnvironmentObject private var userManager: UserManager
    @State private var isPresented: Bool = false
    @State private var folderName: String = ""
    @Environment(\.colorScheme) var scheme
    
    var body: some View {
        NavigationStack {
            VStack{
                HStack {
                    VStack (alignment: .leading){
#warning("Mudar para o nome do usuário")
                        Text("E aí, Manu?")
                            .font(.system(size: 15))
                        Text("Minha Estante")
                            .font(.system(size: 34, design: .serif))
                    }
                    .padding(.top, 30)
                    Spacer()
                    Button {
                        isPresented.toggle()
                    } label: {
                        Image("addFolders")
                            .resizable()
                            .frame(width: 36, height: 24)
                    }
                    .padding(.top, 40)
                    .alert("Criar nova pasta", isPresented: $isPresented) {
                        TextField(folderName, text: $folderName)
                        Button("Cancelar",action: {})
                        Button("Salvar",action: {
                            userManager.createFolder(folderName: folderName)
                        })
                    } message: {
                        Text("Insira o nome desejado para a pasta.")
                    }
                }
                .padding()
                
                Spacer()
                
                VStack {
                    ScrollView {
                        ForEach(userManager.folders) { folder in
                            FolderView(folder: folder)
                                .padding(.bottom, 10)
                        }
                    }
                }
            }
//            .padding()
            .background(
                Image("backgroundImage")
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
            )
        }
    }
}


struct Previews_LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}
