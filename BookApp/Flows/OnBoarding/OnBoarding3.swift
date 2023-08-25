import SwiftUI

struct OnBoarding3: View {
    @Binding var onboarding: Bool
    @EnvironmentObject var userManager: UserManager
    
    var body: some View {
        VStack{
            GeometryReader { geometry in
                VStack {
                    VStack{
                        VStack{
                            Image("onb3")
                                .resizable()
                                .frame(width: 330, height: 400)
                        }
                        .frame(height: 340)
                        
                        VStack{
                            Text("Um universo inteiro: vá além da sua estante e com a ajuda da nossa Inteligência Artificial descubra coisas novas sobre as histórias que você gosta - ou até mesmo novas histórias!")
                                .font(.system(size: 17, weight: .regular))
                                .multilineTextAlignment(.center)
                                .padding([.horizontal, .top])
                        }
                    }
                    .padding(.top, 50)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
            
            //BOTAO
            VStack{
                if !userManager.userAlreadyOnCK {
                    NavigationLink(destination: SetUpInicial(onboarding: $onboarding)
                        .navigationBarBackButtonHidden(true), label: {
                            ZStack {
                                Rectangle()
                                    .fill(Color("primary"))
                                    .cornerRadius(22)
                                    .frame(width: 125, height: 39)
                                Text("Começar")
                                    .font(.system(size: 17, weight: .regular))
                                    .foregroundColor(.white)
                            }
                        })
                } else {
                    Button(action: {
                        self.onboarding = false
                    } ,label: {
                        ZStack {
                            Rectangle()
                                .fill(Color("primary"))
                                .cornerRadius(22)
                                .frame(width: 125, height: 39)
                            Text("Começar")
                                .font(.system(size: 17, weight: .regular))
                                .foregroundColor(.white)
                        }
                    })
                }
            }
            .padding(.bottom, 40)
        }
    }
}
