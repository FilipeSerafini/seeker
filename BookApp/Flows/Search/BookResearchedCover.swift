import SwiftUI

struct BookResearchedCover: View {
    
    @State private var isLinkActive = false
    let book: Book
    
    var body: some View {
        NavigationStack{
            VStack{
                Image(uiImage: book.imageCover ?? UIImage(named: "bookImage")!)
                    .resizable()
                    .scaledToFill()
                    .onTapGesture {
                        isLinkActive = true
                    }
            }
            .frame(width: 95, height: 136)
            .cornerRadius(8)
            #warning("Fazer essa navegação funcionar")
//            .navigationDestination(isPresented: $isLinkActive, destination: { BookView() })
        }
    }
}
//struct ItemSearch_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemSearch()
//    }
//}
