import SwiftUI

struct ResearchedBookView: View {
    @State private var startConfirm = false
    @State var book: Book
    
    var body: some View {
        NavigationStack{
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
                            .padding(.bottom, 3)
                        #warning("fazer validação se avaliação vier vazia")
                        Text("  Avaliação geral: \(book.rating)  ")
                            .background(Rectangle().fill(Color.black).cornerRadius(20).frame(height: 25))
                            .font(.system(size: 13))
                            .foregroundColor(.white)
                            .padding(.bottom, 3)
                        Text(book.sinopsis)
                            .font(.system(size: 15))
                    }
                }
                .onTapGesture {
                    startConfirm.toggle()
                }
            }
            .navigationDestination(isPresented: $startConfirm, destination: { BookView(book: book) })

        }
        .foregroundColor(.black)
        .frame(maxWidth: .infinity, maxHeight: 140, alignment: .topLeading)
        .padding([.leading, .trailing])
        .padding(.bottom, 5)
    }
}

//struct ResearchedBookView_Previews: PreviewProvider {
//    static var previews: some View {
//        ResearchedBookView(book: <#T##Book#>)
//    }
//}
