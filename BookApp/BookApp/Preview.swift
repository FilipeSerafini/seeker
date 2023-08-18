import SwiftUI

struct Preview: View {
    var body: some View {
        HStack {
            Image("previewImage")
                .resizable()
                .frame(width: 269, height: 194)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("backgroundColor"))
    }
}

struct Preview_Previews: PreviewProvider {
    static var previews: some View {
        Preview()
    }
}
