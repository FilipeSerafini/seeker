import SwiftUI

struct FolderCardView: View {
    @State private var isPresented: Bool = false
    @EnvironmentObject var folderViewModel: FolderViewModel
    
    let folder: Folder
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        
        VStack{
            if (folderViewModel.books.isEmpty){
                Image("emptyStateFolder")
                    .resizable()
                    .frame(width: 328, height: 269)
                    .padding(.top, 150)
                
                Text("Ah não! Parece que não temos nenhum livro por aqui. Que tal começarmos a pesquisar alguns? Clique no ícone de busca abaixo e comece a explorar!")
                    .font(.system(size: 15, weight: .regular))
                    .multilineTextAlignment(.center)
                    .padding()
                
            }
            else {
                
                VStack{
                    ScrollView(showsIndicators: false) {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(folderViewModel.books) { book in
                                BookResearchedCover(book: book)
                            }
                            .padding(.top, 20)
                        }
                        Spacer()
                    }
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
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing){
                NavigationLink(destination: FolderCardViewEdit(folder: folder)
                    .environmentObject(folderViewModel)
                               , label: {
                    Image("pencil")
                })
            }
            ToolbarItem(placement: .principal) {
                HStack {
                    Text(folder.name)
                        .font(.system(size: 22, weight: .medium, design: .serif))
                }
            }
        }

    }
}

//struct FolderCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        FolderCardView()
//    }
//}
