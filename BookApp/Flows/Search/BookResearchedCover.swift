import SwiftUI

struct BookResearchedCover: View {
    @State private var startConfirm = false
    let book: Book
    @EnvironmentObject var ratingViewModel: RatingViewModel
    
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
        .navigationDestination(isPresented: $startConfirm, destination: { BookView(book: book) })
    }
}
