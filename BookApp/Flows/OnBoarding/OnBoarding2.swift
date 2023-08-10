import SwiftUI

struct OnBoarding2: View {
    var body: some View {
        VStack {
            HStack {
                Spacer()
                NavigationLink(destination: SetUpInicial().navigationBarBackButtonHidden(true), label: {
                    Text("Skip")
                        .font(.system(size: 20))
                        .foregroundColor(.gray)
                }).padding(25)
            }
            VStack{
                VStack{
                    Image("zoeChat")
                        .resizable()
                        .frame(width: 398, height: 276)
                }
                .frame(height: 350)
                
                VStack{
                    Text("Organize seus livros em pastas da maneira que preferir: mantendo tudo super simples ou super detalhado!")
                        .font(.system(size: 13, weight: .regular))
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: 290)
                    Spacer()
                }
            }
        }
        .preferredColorScheme(.light)
    }
}

struct OnBoarding2_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            OnBoarding2()
        }
    }
}
