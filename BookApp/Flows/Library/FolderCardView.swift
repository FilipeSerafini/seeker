import SwiftUI

struct FolderCardView: View {
    
    let folder: Folder
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    @EnvironmentObject var libraryViewModel: LibraryViewModel
    
    var body: some View {
        
        VStack{
            Text(folder.name)
            Text("LIVROS")
            LazyVGrid(columns: columns, spacing: 20) {
                
                ForEach(libraryViewModel.books) { book in
                    BookResearchedCover(book: book)
                }
            }
            Text("Poder editar o restante")
        }
    }
}

//struct FolderCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        FolderCardView()
//    }
//}
