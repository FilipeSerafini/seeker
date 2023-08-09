import SwiftUI

struct Preview: View {
    var body: some View {
        VStack{
            Image("previewImage")
                .resizable()
                .frame(width: 340, height: 340)
            Text("Welcome to Seeker")
                .font(.system(size: 22, weight: .medium, design: .serif))
                .padding(.top, -80)
        }
    }
}

struct Preview_Previews: PreviewProvider {
    static var previews: some View {
        Preview()
    }
}
