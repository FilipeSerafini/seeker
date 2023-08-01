import SwiftUI

struct ResearchedBookView: View {
    @State private var startConfirm = false
    @State var book: Book
    
    var body: some View {
        NavigationStack{
            ZStack{
                HStack{
                    VStack{
                        Image(uiImage: book.imageCover ?? UIImage(named: "bookImage")!)
                            .resizable()
                            .scaledToFill()
                    }
                    .frame(width: 95, height: 136)
                    .cornerRadius(8)
                    
                    VStack(alignment: .leading){
                        Text(book.authors[0])
                            .font(.system(size: 13))
                        Text(book.title)
                            .font(.system(size: 22, weight: .medium, design: .serif))
                        Text(book.sinopsis)
                            .font(.system(size: 15))
                    }
                }
                .onTapGesture {
                    startConfirm.toggle()
                }
            }
            .confirmationDialog(book.title, isPresented: $startConfirm, titleVisibility: .visible) {
                NavigationLink("Ver detalhes") { BookView()  }
#warning("Mudar para a página de adicionar a uma lista")
                NavigationLink("Adicionar a uma lista") { BookView() }
            } message: {
                Text (book.authors[0])
            }
        }
        .foregroundColor(.black)
        .frame(maxWidth: .infinity, maxHeight: 140, alignment: .topLeading)
        .padding([.leading, .trailing])
        .padding(.bottom, 5)
    }
}

//struct ItemSearchad_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemSearchad()
//    }
//}
