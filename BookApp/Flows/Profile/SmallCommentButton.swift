import SwiftUI

struct SmallCommentButton: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(Color("commentButton"))
            .frame(width: 175, height: 70)
    }
}

struct SmallCommentButton_Previews: PreviewProvider {
    static var previews: some View {
        SmallCommentButton()
    }
}
