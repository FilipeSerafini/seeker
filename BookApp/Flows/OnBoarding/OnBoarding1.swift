import SwiftUI

struct OnBoarding1: View {
    var body: some View {
        VStack {
            HStack {
                Spacer()
                NavigationLink(destination: LibraryView().navigationBarBackButtonHidden(true), label: {
                    Text("Skip")
                        .font(.system(size: 20))
                        .foregroundColor(.gray)
                }).padding(25)
            }
            VStack{
                VStack{
                    Image("zoeImage")
                        .resizable()
                        .frame(width: 398, height: 336)
                }
                .frame(height: 350)
                
                VStack{
                    Text("Bem-vindos!")
                        .font(.system(size: 34, design: .serif))
                        .multilineTextAlignment(.center)
                        .padding(3)
                    Text("Esse é o nosso app!")
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: 290)
                    Spacer()
                }
            }
        }
        .preferredColorScheme(.light)
    }
}

struct OnBoarding1_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            OnBoarding1()
        }
    }
}
