import SwiftUI

struct Preview: View {
    var body: some View {
        VStack{
            Image("previewImage")
                .resizable()
                .frame(width: 269, height: 229)
        }
    }
}

struct Preview_Previews: PreviewProvider {
    static var previews: some View {
        Preview()
    }
}
