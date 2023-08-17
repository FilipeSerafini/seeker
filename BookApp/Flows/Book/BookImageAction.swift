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
                folder.books.removeAll(where: { $0 == book.id })
                
                var folderToUpdate = folder
                
                folderToUpdate.record["books"] = folder.books
                
                CloudKitUtility.update(item: folder) { result in
                    switch result {
                    case .success(_):
                        break
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                
                userManager.fetchFolders()
            }
        } message: {
            Text (book.authors[0])
        }
    }
}
