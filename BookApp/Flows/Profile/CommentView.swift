import SwiftUI

struct CommentView: View {
    
    var bookTitle: String = ""
    var userComment : String = ""
    
    var body: some View {
        VStack (alignment: .leading){
            Text(bookTitle)
                .padding(.bottom, 1)
                .font(.system(size: 22, design: .serif))
            Text(userComment)
                .font(.system(size: 17))
        }
        .padding()
        .background(.ultraThickMaterial)
        .cornerRadius(8)
        .frame(width: 175)
    }
}

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView(bookTitle: "Book title", userComment: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor.")
    }
}
