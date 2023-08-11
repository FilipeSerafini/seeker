import SwiftUI

struct OnBoarding2: View {
    var body: some View {
        VStack {
            VStack{
                VStack{
                    Image("onb2")
                        .resizable()
                        .frame(width: 340, height: 340)
                }
                .frame(height: 350)
                
                VStack{
                    Text("Nunca perca um detalhe: avalie e comente suas leituras preferidas sempre que quiser.")
                        .font(.system(size: 17, weight: .regular))
                        .multilineTextAlignment(.center)
                        .padding()
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

struct OnBoarding2_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            OnBoarding2()
        }
    }
}
