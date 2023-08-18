import SwiftUI

struct FolderCardView: View {
    @State private var isPresented: Bool = false
    @EnvironmentObject var folderViewModel: FolderViewModel
    @State private var onEdit: Bool = false
    @Environment (\.dismiss) var dismiss
    @EnvironmentObject var userManager: UserManager
    @State private var newFolderName: String = ""
    @State private var showEditName: Bool = false
    
    let folder: Folder
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        VStack{
            
            if (folderViewModel.books.isEmpty){
                VStack{
                    Image("emptyStateFolder")
                        .resizable()
                        .frame(width: 328, height: 269)
                        .padding(.top, 150)
                    
                    Text("Ah não! Parece que não temos nenhum livro por aqui. Que tal começarmos a pesquisar alguns? Clique no ícone de busca abaixo e comece a explorar!")
                        .font(.system(size: 15, weight: .regular))
                        .multilineTextAlignment(.center)
                    .padding()
                }
                Spacer()
            }
            else {
                
                if onEdit {
                    VStack{
                        Button {
                            showEditName.toggle()
                        } label: {
                            Image("addFolders")
                                .resizable()
                                .frame(width: 34, height: 25)
                        }
                        .padding(.top, 20)
                        .alert("Alterar nome da pasta", isPresented: $showEditName) {
                            TextField("Novo nome", text: $newFolderName)
                            Button("Cancelar",action: {})
                            Button("Confirmar", action: {})
                        } message: {
                            Text("Defina um novo nome para a pasta.")
                        }
                        ScrollView(showsIndicators: false) {
                            LazyVGrid(columns: columns, spacing: 20) {
                                ForEach(folderViewModel.books) { book in
                                    BookImageAction(folder: folder, book: book)
                                }
                            }
                        }
                        Spacer()                        
                    }
                    .padding(.top, 20)
                    .padding(.bottom)
                } else {
                    ScrollView(showsIndicators: false) {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(folderViewModel.books) { book in
                                BookResearchedCover(book: book)
                            }
                            .padding(.top, 33)
                        }
                        
                    }
                }
                
            }
            if folder.description != "NaoApagar" && onEdit {
                Button {
                    isPresented.toggle()
                } label: {
                    ZStack {
                        Rectangle()
                            .fill(.clear)
                            .cornerRadius(22)
                            .overlay {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(lineWidth: 1)
                                    .fill(.red)
                            }
                            .frame(width: 126, height: 36)
                        HStack{
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                            Text("Apagar pasta")
                                .font(.system(size: 13, weight: .regular))
                                .foregroundColor(Color("text"))
                        }
                    }
                    .padding(.bottom)
                }
                .alert("Tem certeza que deseja apagar essa pasta?", isPresented: $isPresented) {
                    Button("Cancelar", role: .cancel, action: {})
                    Button("Apagar", role: .destructive,action: {
                        CloudKitUtility.delete(item: folder)
                        userManager.fetchFolders()
                        dismiss()
                    })
                } message: {
                    Text("Essa ação não poderá ser desfeita.")
                }
            }
        }
        .toolbar {
            if onEdit {
                ToolbarItem(placement: .navigationBarTrailing){
                    Button {
                        onEdit = false
                    } label: {
                        Image("saveFolder")
                    }
                }
            }
            else {
                ToolbarItem(placement: .navigationBarTrailing){
                    Button {
                        onEdit = true
                    } label: {
                        Image("pencil")
                    }
                }
            }
            ToolbarItem(placement: .principal) {
                HStack {
                    Text(folder.name)
                        .font(.system(size: 22, weight: .medium, design: .serif))
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image("backgroundImage")
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
        )
        
    }
}
