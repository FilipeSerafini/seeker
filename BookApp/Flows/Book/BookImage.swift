import SwiftUI

struct BookImage: View {
    @State private var startConfirm = false
    let book: Book
    var body: some View {
        
        VStack {
            Image(uiImage: book.imageCover ?? UIImage(named: "bookImage")!)
                .resizable()
                .scaledToFill()
                .onTapGesture {
                    startConfirm.toggle()
                }
        }
        .frame(width: 95, height: 136)
        .cornerRadius(8)
    }
}
