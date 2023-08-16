import SwiftUI

struct LibraryView: View {
    
    @EnvironmentObject private var userManager: UserManager
    @State private var isPresented: Bool = false
    @State private var folderName: String = ""
    @State private var myName = UserDefaults.standard.value(forKey: "name") as? String ?? ""
    @Environment(\.colorScheme) var scheme
    
    var body: some View {
        NavigationStack {
            VStack{
                HStack {
                    VStack (alignment: .leading){
#warning("Mudar para o nome do usuário")
                        Text("E aí, \(myName)?")
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
                    
                    #warning("VER PORQUE NAO ESTA LIMITANDO NA CAIXA DE TEXTO")
//                    .alert("Criar nova pasta", isPresented: $isPresented) {
//                        TextField(folderName, text: $folderName)
//                            .onChange(of: folderName) { newValue in
//                                let allowedCharacterSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ")
//                                let filteredText = newValue.filter { allowedCharacterSet.contains(UnicodeScalar(String($0))!) }
//                                folderName = String(filteredText.prefix(25))
//                            }
//                        Button("Cancelar",action: {})
//                        Button("Salvar",action: {
//                            userManager.createFolder(folderName: folderName)
//                        })
//                    } message: {
//                        Text("Insira o nome desejado para a pasta.")
//                    }
                    
                    
                    
                }
                .padding()
                
                Spacer()
                
                VStack {
                    ScrollView(showsIndicators: false){
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
            .background(Color("backgroundColor"))
            
        }
        .onAppear{
            userManager.fetchFolders()
        }
    }
}


struct Previews_LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}
