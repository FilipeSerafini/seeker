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
                        Text("E aí, \(myName)?")
                            .font(.system(size: 15))
                        Text("Minha Estante")
                            .font(.system(size: 34, weight: .semibold, design: .serif))
                    }
                    Spacer()
#warning("VER PORQUE NAO ESTA LIMITANDO NA CAIXA DE TEXTO")
                    Button {
                        isPresented.toggle()
                    } label: {
                        Image("addFolders")
                            .resizable()
                            .frame(width: 34, height: 25)
                    }
                    .padding(.top, 20)
                    .alert("Criar nova pasta", isPresented: $isPresented) {
                        TextField("Nova pasta", text: $folderName)
                            .onChange(of: folderName) { newValue in
                                folderName = String(newValue.prefix(25))
                            }
                        Button("Cancelar",action: {})
                        Button("Criar",action: {
                            userManager.createFolder(folderName: folderName)
                        })
                    } message: {
                        Text("Defina um nome para a nova pasta. Assim que criada, ela aparecerá na sua estante.")
                    }
                }
                .padding(.top, 30)
                .padding(.bottom, 10)
                .padding(.horizontal)
                
                Spacer()
                
                VStack {
                    ScrollView(showsIndicators: false){
                        ForEach(userManager.folders) { folder in
                            FolderView(folder: folder)
                                .padding(.bottom, 10)
                        }
                        .padding(.top, 10)
                    }
                }
            }
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
