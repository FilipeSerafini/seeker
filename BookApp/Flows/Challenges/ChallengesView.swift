import SwiftUI

struct ChallengesView: View {
    var body: some View {
        VStack (alignment: .leading){
            Text("Desafios de leitura")
                .font(.system(size: 34, design: .serif))
                .frame(alignment: .leading)
            
            ZStack{
                RoundedRectangle(cornerRadius: 30)
                    .fill(.gray)
                    .frame(width: 358, height: 170)
            }
            Spacer()
        }
        .padding()
    }
}

struct ChallengesView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengesView()
    }
}
