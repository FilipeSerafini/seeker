import SwiftUI

struct AddReview: View {
    @State var book: Book
    @State private var titleReview = ""
    @State private var addReview = ""
    @EnvironmentObject var profileViewModel: ProfileViewModel
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                HStack {
                    VStack {
                        Image(uiImage: book.imageCover ?? UIImage(named: "bookImage")!)
                            .resizable()
                            .frame(width: 62, height: 88)
                            .cornerRadius(10)
                            .shadow(color: Color("shadowBook"), radius: 4, x: 2, y: 4)
                    }
                    
                    VStack(alignment: .leading) {
                        Text(book.authors[0])
                            .font(.system(size: 13))
                            .textCase(.uppercase)
                        Text(book.title)
                            .font(.system(size: 22, weight: .medium, design: .serif))
                    }
                    .padding(.bottom, 30)
                    Spacer()
                }
                .padding(.top, 30)
                .padding(.horizontal)
                Divider()
                    .padding(.horizontal)
                VStack {
                    TextField("Título da nota", text: $titleReview)
                        .textFieldStyle(.plain)
                        .font(.system(size: 22, weight: .medium, design: .serif))
                    
                    TextField("Adicionar nota", text: $addReview, axis: .vertical)
                        .textFieldStyle(.plain)
                        .font(.system(size: 17))
                    
                    Spacer()
                }
                .padding(.horizontal)
            }
            .background(
                Image("backgroundImage")
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
            )
            .background(Color("backgroundColor"))
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text("Adicionar nota")
                        .font(.system(size: 22, weight: .medium, design: .serif))
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    let comment = CommentReview(comment: addReview, bookID: book.id, bookTitle: book.title, bookAuthor: book.authors[0], bookImageURL: book.image, commentTitle: titleReview)
                    profileViewModel.saveUserCommentReview(comment: comment!)
                    dismiss()
                }
            label: {
                Image("saveFolder")
            }
            }
        }
    }
}
