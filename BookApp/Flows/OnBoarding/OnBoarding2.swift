import SwiftUI

struct OnBoarding2: View {
    var body: some View {
        VStack{
            GeometryReader { geometry in
                VStack{
                    VStack{
                        Image("onb2")
                            .resizable()
                            .frame(width: 340, height: 340)
                    }
                    VStack{
                        Text("Nunca perca um detalhe: avalie e comente suas leituras preferidas sempre que quiser.")
                            .font(.system(size: 17, weight: .regular))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                }
                .padding(.top, 30)
                .ignoresSafeArea()
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
            }
        }
        .padding(.bottom, 90)
    }
}
