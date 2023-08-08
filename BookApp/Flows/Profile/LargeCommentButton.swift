import SwiftUI

struct LargeCommentButton: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 30)
            .fill(Color("commentButton"))
            .frame(width: 175, height: 225)
    }
}

struct LargeCommentButton_Previews: PreviewProvider {
    static var previews: some View {
        LargeCommentButton()
    }
}
