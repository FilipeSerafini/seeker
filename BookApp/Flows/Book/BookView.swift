import SwiftUI

struct BookView: View {
    @State var book: Book
    @State var rating: Int = 0
    @State var showSheet: Bool = false
    @State private var startConfirm = false
    
    var body: some View {
        VStack{
            Image(uiImage: book.imageCover ?? UIImage(named: "bookImage")!)
                .resizable()
                .frame(width: 136, height: 195)
                .cornerRadius(15)
                .shadow(color: Color("shadowBook"), radius: 4, x: 2, y: 4)
                .padding(.top)
                .padding(.top, 100)
            
            ScrollView(showsIndicators: false){
                Text (book.authors[0])
                    .multilineTextAlignment(.center)
                    .textCase(.uppercase)
                    .font(.system(size: 15, weight: .regular))
                    .padding(.top)
                    .padding(.bottom, 5)
                    .textSelection(.enabled)
                
                Text (book.title)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 22, weight: .medium, design: .serif))
                    .frame(alignment: .center)
                    .textSelection(.enabled)
                
                RatingButton(book: self.$book, rating: self.$rating)
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                
                Text (book.sinopsis)
                    .font(.system(size: 17, weight: .regular))
                    .padding(.bottom)
            }
        }
        .edgesIgnoringSafeArea(.top)
        .padding(.horizontal)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing){
                Button {
                    startConfirm.toggle()
                }
            label: {
                VStack{
                    Image("addBookToFolder")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding(.trailing, -10)
                }
                .confirmationDialog(book.title, isPresented: $startConfirm, titleVisibility: .visible){
                    NavigationLink("Adicionar a uma pasta") { AddToFolderView(book: book)  }
                    NavigationLink("Adicionar nota")
                    { AddReview(book: book) }
                    Button("Cancelar", role: .cancel, action: {})
                } message: {
                    Text (book.authors[0])
                }
            }
            }
            ToolbarItem(placement: .navigationBarTrailing){
                Button {
                    let customView = SharedInstagramView(book: book)
                    if let viewImageData = customView.toImage().pngData() {
                        shareImageOnInstagramStories(imageData: viewImageData)
                    }
                }
            label: {
                Image("shareButton")
                    .resizable()
                    .frame(width: 22, height: 24)
            }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image("backgroundImage")
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
        )
        .background(Color("backgroundColor"))
    }
}





