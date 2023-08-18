import SwiftUI

struct BookImageAction: View {
    @State private var isAnimated = false
    @State private var isPresented: Bool = false
    @State private var startConfirm = false
    @State var folder: Folder
    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject var folderViewModel: FolderViewModel
    let book: Book
    
    var body: some View {
        VStack {
            Image(uiImage: book.imageCover ?? UIImage(named: "bookImage")!)
                .resizable()
                .scaledToFill()
                .frame(width: 95, height: 136)
                .cornerRadius(8)
                .onTapGesture {
                    startConfirm.toggle()
                }
            
            Button {
                isPresented.toggle()
            } label: {
                Image(systemName: "minus.circle.fill")
                    .resizable()
                    .foregroundColor(Color("deleteBook"))
                    .frame(width: 30, height: 30)
            }
            .padding(.top, -155)
            .padding(.leading, -60)
            .alert("Remover livro da pasta", isPresented: $isPresented) {
                Button("Cancelar", role: .cancel , action: {})
                Button("Remover", role: .destructive, action: {
                    folder.books.removeAll(where: { $0 == book.id })
                    folderViewModel.books.removeAll(where: { $0.id == book.id })
                    
                    var folderToUpdate = folder
                    
                    folderToUpdate.record["books"] = folder.books
                    folderToUpdate.books = folder.books
                    
                    let folders: [Folder] = [folderToUpdate]
                    
                    userManager.updateFolders(folders: folders) {}
                })
            } message: {
                Text("Tem certeza que deseja remover \(book.title) da pasta?")
            }
        }
        .padding()
        .frame(width: 100, height: 170)
        .rotationEffect(.degrees(isAnimated ? 2.5 : 0))
        .animation(
            .easeInOut(duration: 0.15)
            .repeatForever(autoreverses: true), value: isAnimated)
        .onAppear{
            isAnimated.toggle()
        }
    }
}
