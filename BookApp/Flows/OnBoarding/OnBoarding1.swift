import SwiftUI

struct OnBoarding1: View {
    var body: some View {
        VStack{
            GeometryReader { geometry in
                VStack{
                    VStack{
                        Image("onb1")
                            .resizable()
                            .frame(width: 330, height: 330)
                    }
                    VStack{
                        Text("Organize seus livros em pastas da maneira que preferir: mantendo tudo super simples ou super detalhado!")
                            .font(.system(size: 17, weight: .regular))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                }
                .padding(.top, 60)
                .ignoresSafeArea()
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
            }
        }
        .padding(.bottom, 110)
    }
}
