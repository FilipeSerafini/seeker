import SwiftUI

struct Preview: View {
    var body: some View {
        VStack{
//            Image("bookImage")
//                .resizable()
//                .frame(width: 340, height: 340)
            Text("Welcome!")
//            Text("Welcome to Seeker")
                .font(.system(size: 34, design: .serif))
                .padding(.bottom,4)
                .padding(.top, -80)
        }
        
    }
}

struct Preview_Previews: PreviewProvider {
    static var previews: some View {
        Preview()
    }
}
