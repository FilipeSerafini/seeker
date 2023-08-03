import SwiftUI

struct LibraryView: View {
    
    var userName: String = ""
    @EnvironmentObject private var searchViewModel: SearchViewModel
    @ObservedObject private var viewModel: LibraryViewModel = LibraryViewModel()
    @State private var isPresented: Bool = false
    @State private var folderName: String = ""

    var body: some View {
        VStack{
            HStack{
                VStack (alignment: .leading){
                    Text("E aí, \(userName)?")
                        .font(.system(size: 15, design: .serif))
                    
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
                    viewModel.createFolder(folderName: folderName)
                })
            }message: {
                Text("Insira o nome desejado para a pasta.")
            }
            }
            .padding()
            
            NavigationStack {
                ScrollView {
                    ForEach(viewModel.folders.indices, id: \.self) { index in
                        VStack {
                            
                            Text(viewModel.folders[index].name)
                            
                            Text(viewModel.folders[index].description)
                        }
                        .padding()
                        .background(Color.teal)
                    }
                }
                .navigationBarTitle("TESTE PASTAS")
            }
        }
    }
}
//
//struct LibraryView_Previews: PreviewProvider {
//    static var previews: some View {
//        LibraryView(userName: "Schar")
//    }
//}
