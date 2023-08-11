import SwiftUI

struct BookView: View {
    @State var book: Book
    @State var rating: Int = 3
    @State var showSheet: Bool = false
    @State private var startConfirm = false
    @StateObject var ratingViewModel: RatingViewModel
    @Environment(\.presentationMode) private var presetationMode: Binding<PresentationMode>
    var body: some View {
        VStack{
            NavigationStack{
                ZStack{
                    VStack{
                        ZStack {
                            Image(uiImage: book.imageCover ?? UIImage(named: "bookImage")!)
                                .resizable()
                                .frame(width: 170, height: 244)
                                .cornerRadius(15)
                                .shadow(color: Color("shadowBook"), radius: 5, x: 5, y: 4)
                        }
                        VStack {
                            ScrollView(showsIndicators: false){
                                
                                Text (book.authors[0])
                                    .multilineTextAlignment(.center)
                                    .textCase(.uppercase)
                                    .font(.system(size: 17, weight: .regular))
                                    .padding(.bottom, 1)
                                
                                Text (book.title)
                                    .multilineTextAlignment(.center)
                                    .font(.system(size: 22, weight: .medium, design: .serif))
                                    .frame(alignment: .center)
                                    .padding(.bottom, 5)
                                    .padding(.top, 1)
                                
                                RatingButton(book: self.$book, rating: self.$rating, ratingViewModel: RatingViewModel())
                                    .padding(.bottom, 10)
                                
                                Text (book.sinopsis)
                                    .font(.system(size: 17, weight: .regular))
                            }
                        }
                        .padding([.leading, .trailing])
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing){
                        Button {}
                    label: {
                        // MARK: Se o livro estiver nas listas Lendo agora e/ou Leituras realizadas, pode ser compartilhado no Insta
                        Image("shareButton")
                    }
                        
                    }
                    ToolbarItem(placement: .navigationBarTrailing){
                        
                        Button {
                            startConfirm.toggle()
                        }
                    label: {
                        VStack{
                            Image("addBookToFolder")
                                .resizable()
                                .frame(width: 24, height: 24)
                        }
                        .confirmationDialog(book.title, isPresented: $startConfirm, titleVisibility: .visible) {
                            NavigationLink("Adicionar a uma lista") { AddToFolderView(book: book)  }
                            NavigationLink("Adicionar uma nota") { AddReview(book: book) }
                        } message: {
                            Text (book.authors[0])
                        }
                    }
                    }
                }
            }
        }
        .background(
            Image("backgroundImage")
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
        )
    }
}





