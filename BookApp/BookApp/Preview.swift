import SwiftUI

struct Preview: View {
    var body: some View {
        VStack{
            Image("zoeChat")
                .resizable()
                .frame(width: 340, height: 240)
            Text("Bem-vindo ao Seeker")
                .font(.system(size: 22, weight: .medium, design: .serif))
        }
    }
}

struct Preview_Previews: PreviewProvider {
    static var previews: some View {
        Preview()
    }
}
