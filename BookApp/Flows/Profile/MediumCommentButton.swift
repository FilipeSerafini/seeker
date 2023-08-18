import SwiftUI

struct MediumCommentButton: View {
    var comment: CommentReview
    
    var body: some View {
            NavigationLink {
                OpenComment(comment: comment)
            } label: {
                HStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color("historicPost"))
                        VStack(alignment: .leading, spacing: 4) {
                            Text(comment.bookTitle)
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(Color("historicTitle"))
                                .frame(width: 165, height: 20, alignment: .leading)
                            Text(comment.comment)
                                .font(.system(size: 15, weight: .regular))
                                .foregroundColor(Color("text"))
                                .multilineTextAlignment(.leading)
                        }
                        .padding(.all, 4)
                        .frame(width: 165, height: 95, alignment: .topLeading)
                    }
                    .frame(width: 175, height: 105)
                }
            }
    }
}

struct MediumCommentButton_Previews: PreviewProvider {
    static var previews: some View {
        MediumCommentButton(comment: CommentReview(comment: "aa", bookID: "32", bookTitle: "a", bookAuthor: "aaa", bookImageURL: "aa", commentTitle: "titulo")!)
    }
}
