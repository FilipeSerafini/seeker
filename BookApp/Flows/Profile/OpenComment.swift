import SwiftUI

struct OpenComment: View {
    @State var comment: CommentReview
    private let service: BookService = BookService()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading){
                HStack{
                    VStack {
                        if let url = URL(string: comment.bookImageURL) {
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                            } placeholder: {
                                Image("bookImage")
                                    .resizable()
                            }
                        } else {
                            Image("bookImage")
                        }
                    }
                    .frame(width: 62, height: 88)
                    .cornerRadius(10)
                    .shadow(color: Color("shadowBook"), radius: 4, x: 2, y: 4)
                    
                    VStack(alignment: .leading){
                        Text(comment.bookAuthor)
                            .font(.system(size: 13))
                            .textCase(.uppercase)
                        Text(comment.bookTitle)
                            .font(.system(size: 22, weight: .medium, design: .serif))
                    }
                    Spacer()
                }
                .padding(.top, 30)
                .padding(.horizontal)
                Divider()
                    .padding(.horizontal)
                
                VStack(alignment: .leading){
                    Text(comment.commentTitle)
                        .font(.system(size: 22, weight: .medium, design: .serif))
                        .padding(.vertical, 5)
                        .multilineTextAlignment(.leading)
                    Text(comment.comment)
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
                    Text(comment.bookTitle)
                        .font(.system(size: 22, weight: .medium, design: .serif))
                }
            }
        }
    }
}
