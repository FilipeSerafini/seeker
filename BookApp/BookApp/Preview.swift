import SwiftUI

struct Preview: View {
    var body: some View {
        VStack{
            Image("previewImage")
                .resizable()
                .frame(width: 340, height: 340)
            Text("Welcome to Skeeper")
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
