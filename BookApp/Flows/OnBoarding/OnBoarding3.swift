import SwiftUI

struct OnBoarding3: View {
    
    var body: some View {
        VStack() {
            VStack{
                Image("zoeChat")
                    .resizable()
                    .frame(width: 350, height: 276)
            }
            .frame(height: 350)
            
            VStack(alignment: .center) {
                Text("Um universo inteiro: vá além da sua estante e descubra coisas novas sobre as histórias que você gosta - ou até mesmo novas histórias!")
                    .font(.system(size: 13, weight: .regular))
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: 290)
            }
            
            //mudar aqui
            NavigationLink(destination: SetUpInicial().navigationBarBackButtonHidden(true), label: {
                ZStack {
                    Rectangle()
                        .fill(Color("primary"))
                        .cornerRadius(30)
                        .frame(width: 168, height: 45)
                    Text("Começar")
                        .font(.system(size: 13, weight: .regular))
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
