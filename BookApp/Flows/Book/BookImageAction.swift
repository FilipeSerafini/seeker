import SwiftUI

struct BookImageAction: View {
    
    @State private var startConfirm = false
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
            NavigationLink("Remover dessa lista") {
                //colocar acao de remover da lista
            }
        } message: {
            Text (book.authors[0])
        }
    }
}
