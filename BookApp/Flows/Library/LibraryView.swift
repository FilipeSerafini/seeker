import SwiftUI

struct LibraryView: View {
    
    //MARK: Animation Properties
    @State var expandFolder: Bool = false
    
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
                } message: {
                    Text("Insira o nome desejado para a pasta.")
                    }
                }
                .padding()
                
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
                .background(.green)
            }
        }
    }
    
    // MARK: Folder View
    @ViewBuilder
    func FolderView(folder: FolderCard)->some View{
        
        GeometryReader {proxy in
            
            let rect = proxy.frame(in: .named("SCROLL"))
            // display some portion of each folder
            let offset = CGFloat(getIndex(folder: folder) * (expandFolder ? 10 : 70))
            let background = getIndex(folder: folder).isMultiple(of: 2) ? Color("primary") : Color("secondary")
            
            let columns = [
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible()),
            ]
            
            ZStack {
                RoundedRectangle (cornerRadius: 20)
                    .fill(background)
                //                    .stroke(.white, lineWidth: 20)
                    .frame(width: 362, height: 647)
                
                ScrollView {
                    Text("Livros lidos")
                        .font(.system(size: 24, design: .serif))
                        .padding(.top, 10)
                    
                    LazyVGrid(columns: columns, spacing: 20) {
                        
                        ForEach(folder.books) { folderBook in
                            BookResearchedCover(book: folderBook)
                        }
                    }
                }
                .frame(maxHeight: 647)
            }
            .overlay {
                //Avoid scrolling
                Rectangle()
                    .fill(.black.opacity(expandFolder ? 0.01 : 0.01))
                    .onTapGesture {
                        if expandFolder {
                            withAnimation(.easeOut(duration: 0.35)){
                                expandFolder = false
                            }
                        } else {
                            withAnimation(.easeInOut(duration: 0.35)){
                                expandFolder = true
                            }
                        }
                    }
            }            //MARK: Making it as a stack
            .offset(y: expandFolder ? offset : -rect.minY + offset)
        }
        // aqui muda o quanto abre a pasta
        .padding(.bottom, 220)
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
