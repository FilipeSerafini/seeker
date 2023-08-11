import SwiftUI

struct OnBoarding1: View {
    var body: some View {
        VStack{
            VStack{
                Image("onb1")
                    .resizable()
                    .frame(width: 330, height: 330)
            }
            .frame(height: 350)
            
            VStack{
                Text("Organize seus livros em pastas da maneira que preferir: mantendo tudo super simples ou super detalhado!")
                    .font(.system(size: 17, weight: .regular))
                    .multilineTextAlignment(.center)
                    .padding()
            }
        }
        
    }
}

//struct OnBoarding1_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack{
//            OnBoarding1()
//        }
//    }
//}
