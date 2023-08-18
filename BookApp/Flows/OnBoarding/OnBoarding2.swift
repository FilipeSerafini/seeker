import SwiftUI

struct OnBoarding2: View {
    var body: some View {
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
            .padding(.bottom, 135)
        }
    }
}
