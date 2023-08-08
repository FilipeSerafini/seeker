import SwiftUI

struct MediumCommentButton: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 30)
            .fill(Color("commentButton"))
            .frame(width: 175, height: 100)
    }
}

struct MediumCommentButton_Previews: PreviewProvider {
    static var previews: some View {
        MediumCommentButton()
    }
}
