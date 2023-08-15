import SwiftUI

struct MediumCommentButton: View {
    
    var comment: CommentReview
    
    var body: some View {
        
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color("commentButton"))
                VStack(alignment: .leading, spacing: 4) {
                    Text(comment.bookTitle)
                        .fontWeight(.semibold)
                        .foregroundColor(Color("comment"))
                        .frame(width: 165, height: 20, alignment: .leading)
                    Text(comment.comment)
                        .font(.subheadline)
                }
                .padding(.all, 4)
                .frame(width: 165, height: 95, alignment: .topLeading)
            }
            .frame(width: 175, height: 105)
        }
    }
}

struct MediumCommentButton_Previews: PreviewProvider {
    static var previews: some View {
        MediumCommentButton(comment: CommentReview(comment: "Não gostei", bookID: "123", bookTitle: "Velozes e Furiosos")!)
    }
}
