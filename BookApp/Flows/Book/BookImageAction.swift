import SwiftUI

struct BookImageAction: View {
    
    @State private var startConfirm = false
    @EnvironmentObject var userManager: UserManager
    @State var folder: Folder
    let book: Book
    var body: some View {
        
        VStack{
            Image(uiImage: book.imageCover ?? UIImage(named: "bookImage")!)
                .resizable()
                .scaledToFill()
                .onTapGesture {
                    startConfirm.toggle()
                }
        }
        .frame(width: 95, height: 136)
        .cornerRadius(8)
        .confirmationDialog(book.title, isPresented: $startConfirm, titleVisibility: .visible) {
            Button("Remover dessa lista") {
                print("antes: ", folder.books)
                
                folder.books.removeAll(where: { $0 == book.id })
                
                var folderToUpdate = folder
                
                folderToUpdate.record["books"] = folder.books
                folderToUpdate.books = folder.books
                
                print(folderToUpdate.books)
                
                let folders: [Folder] = [folderToUpdate]
                
                userManager.updateFolders(folders: folders)
                {
//                    print("Deletou o livro livro")
//                    userManager.fetchFolders()
                }
            }
        } message: {
            Text (book.authors[0])
        }
    }
}
