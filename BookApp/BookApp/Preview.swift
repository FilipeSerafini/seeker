import SwiftUI

struct Preview: View {
    var body: some View {
        VStack{
            Image("bookImage")
                .resizable()
                .frame(width: 340, height: 340)
            Text("Welcome to Seeker")
        }
    }
}

struct Preview_Previews: PreviewProvider {
    static var previews: some View {
        Preview()
    }
}
