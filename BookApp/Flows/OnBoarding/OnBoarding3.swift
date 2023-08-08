import SwiftUI

struct OnBoarding3: View {
    
    var body: some View {
        VStack() {
            VStack{
                Image("zoeImage")
                    .resizable()
                    .frame(width: 350, height: 313)
            }
            .frame(height: 350)
            
            VStack(alignment: .center) {
                Text("Bem-vindos!")
                    .font(.system(size: 34, design: .serif))
                    .multilineTextAlignment(.center)
                    .padding(3)
                Text("Esse é o nosso app!")
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: 290)
            }
            
            //mudar aqui
            NavigationLink(destination: LibraryView().navigationBarBackButtonHidden(true), label: {
                ZStack {
                    Rectangle()
                        .fill(Color("primary"))
                        .cornerRadius(30)
                        .frame(width: 168, height: 45)
                    Text("Start")
                        .font(.system(size: 34, design: .serif))
                        .foregroundColor(.white)
                }
            })
            .padding(.top, 60)
            
        }
        .preferredColorScheme(.light)
    }
}

struct OnBoarding3_Previews: PreviewProvider {
    static var previews: some View {
        OnBoarding3()
    }
}
