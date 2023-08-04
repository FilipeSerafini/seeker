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
            
                ScrollView {
                    ForEach(userManager.folders, id: \.id) { folder in
                        VStack {

                            Text(folder.name)

//                            Text(folder.description)
                        }
                        .padding()
                        .background(Color.teal)
//                    ForEach(viewModel.folders.indices, id: \.self) { index in
//                        VStack {
//
//                            Text(viewModel.folders[index].name)
//
//                            Text(viewModel.folders[index].description)
//                        }
//                        .padding()
//                        .background(Color.teal)
                    }
                }
                
                VStack {
                    Spacer()
                    
                        ZStack{
                            Image(scheme == . light ? "Sheets1" : "Sheets1Dark")
                                .resizable()
                                .frame(width: 382, height: 140)
                                .onTapGesture {
                                    startConfirm.toggle()
                                }
                            

                            HStack{
                                Text("Leituras realizadas")
                                    .font(.system(size: 22, design: .serif))
                                    .foregroundColor(.black)
                                    .padding(.leading, 25)
                                    .padding(.bottom, 50)
                                Spacer()
                            }
                            
                        }
                        .padding(.bottom, -50)
                        .navigationDestination(isPresented: $startConfirm, destination: {OracleView()})

                    
                        ZStack{
                            Image(scheme == . light ? "Sheets2" : "Sheets2Dark")
                                .resizable()
                                .frame(width: 382, height: 140)
                                .onTapGesture {
                                    startConfirm.toggle()
                                }
                            HStack{
                                Text("Livros que quero ler")
                                    .font(.system(size: 22, design: .serif))
                                    .foregroundColor(.black)
                                    .padding(.leading, 25)
                                    .padding(.bottom, 50)
                                Spacer()
                            }
                            
                        }
                        .padding(.bottom, -50)
                        .navigationDestination(isPresented: $startConfirm, destination: {OracleView()})

            

                        ZStack{
                            Image(scheme == . light ? "Sheets1" : "Sheets1Dark")
                                .resizable()
                                .frame(width: 382, height: 140)
                                .onTapGesture {
                                    startConfirm.toggle()
                                }
                            HStack{
                                Text("Lendo agora")
                                    .font(.system(size: 22, design: .serif))
                                    .foregroundColor(.black)
                                    .padding(.leading, 25)
                                    .padding(.bottom, 50)
                                Spacer()
                            }
                            
                        }
                        .padding(.bottom, -30)
                        .navigationDestination(isPresented: $startConfirm, destination: {OracleView()})
               }

                .navigationBarTitle("")
            }
        }
    }
}

