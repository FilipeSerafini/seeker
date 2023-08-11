import SwiftUI

struct OnBoarding3: View {
    var body: some View {
        NavigationStack{
            VStack {
                VStack{
                    VStack{
                        Image("onb3")
                            .resizable()
                            .frame(width: 330, height: 400)
                    }
                    .frame(height: 350)
                    
                    VStack{
                        Text("Um universo inteiro: vá além da sua estante e descubra coisas novas sobre as histórias que você gosta - ou até mesmo novas histórias!")
                            .font(.system(size: 17, weight: .regular))
                            .multilineTextAlignment(.center)
                            .padding()
                        
                        VStack{
                            NavigationLink(destination: SetUpInicial().navigationBarBackButtonHidden(true), label: {
                                ZStack {
                                    Rectangle()
                                        .fill(Color("primary"))
                                        .cornerRadius(22)
                                        .frame(width: 125, height: 39)
                                    Text("Começar")
                                        .font(.system(size: 13, weight: .regular))
                                        .foregroundColor(.white)
                                }
                            })
                            .padding(.top, 60)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Image("backgroundImage")
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
            )
        }
    }
}


struct OnBoarding3_Previews: PreviewProvider {
    static var previews: some View {
        OnBoarding3()
    }
}
