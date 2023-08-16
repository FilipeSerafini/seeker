import SwiftUI

struct Preview: View {
    var body: some View {
        VStack{
            Image("previewImage")
                .resizable()
                .frame(width: 269, height: 229)
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
