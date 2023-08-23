import SwiftUI

struct ResearchedBookView: View {
    @State private var startConfirm = false
    @State var book: Book
    @Environment(\.colorScheme) var scheme
    
    var body: some View {
        ZStack{
            HStack{
                VStack{
                    Image(uiImage: book.imageCover!)
                        .resizable()
                        .scaledToFill()
                }
                .frame(width: 95, height: 136)
                .cornerRadius(8)
                
                VStack(alignment: .leading){
                    Text(book.authors[0])
                        .textCase(.uppercase)
                        .font(.system(size: 13))
                        .padding(.bottom, -4)
                    Text(book.title)
                        .font(.system(size: 22, weight: .medium, design: .serif))
                    Text(book.sinopsis)
                        .font(.system(size: 15))
                }
                .foregroundColor(scheme == .light ? .black : .white)
            }
            .onTapGesture {
                startConfirm.toggle()
            }
        }
        .navigationDestination(isPresented: $startConfirm, destination: { BookView(book: book) })
        .foregroundColor(.black)
        .frame(maxWidth: .infinity, maxHeight: 140, alignment: .topLeading)
        .padding([.leading, .trailing])
        .padding(.bottom, 5)
    }
}
